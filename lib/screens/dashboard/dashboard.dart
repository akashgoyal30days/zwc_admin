import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/controllers/dashboard_controller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/Navigation_drawer.dart';
import 'package:zwc/widgets/Members_data.dart';

import '../../widgets/environment_saved.dart';
import '../../widgets/statistics.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(2023, DateTime.now().month, DateTime.now().day - 60),
      end: DateTime.now());

  final DashboardController dashboardcontroller =
      Get.put(DashboardController());
  String? branchdropdownvalue;
  String? apicallbranchid;
  @override
  void initState() {
    dashboardcontroller.getallbranches().then((value) => {
          getdashboardbranchid(),
          if (branchdropdownvalue.toString() != "null" &&
              branchdropdownvalue.toString() != "0")
            {apicallbranchid = branchdropdownvalue.toString()}
          else
            {apicallbranchid = "0"},
          if (dashboardcontroller.drywetwastecollection.isEmpty)
            {
              dashboardcontroller.getDashboard(
                  dateRange, apicallbranchid.toString(), "month")
            }
        });

    super.initState();
  }

  getdashboardbranchid() async {
    branchdropdownvalue =
        SharedPreferenceSingleTon.getData("dashboard_branch_id").toString();
    log(branchdropdownvalue.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        drawer: Navigationdrawer(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: Text(
            "Dashboard",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () async {
                var dates = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2010),
                  lastDate: DateTime.now(),
                  initialDateRange: dateRange,
                );
                if (dates == null) return;
                if (dateRange.start != dates.start ||
                    dateRange.end != dates.end) {
                  dateRange = dates;
                  controller.getDashboard(dateRange, "0", "month");
                  setState(() {});
                }
              },
            )
          ],
          centerTitle: true,
        ),
        body: SafeArea(
            child: controller.showLoading
                ? const Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : RawScrollbar(
                    thumbColor: Colors.green,
                    trackVisibility: true,
                    thickness: 5,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                              child: Center(
                            child: DropdownButton(
                              value: branchdropdownvalue,
                              underline: SizedBox(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              hint: Text(
                                "All Branches",
                                style: GoogleFonts.roboto(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              items: dashboardcontroller.getallbranchdata!.data!
                                  .map((item) {
                                return DropdownMenuItem(
                                  value: item.id,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${item.branchName}",
                                            style: GoogleFonts.roboto(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${item.id}",
                                            style: GoogleFonts.roboto(
                                                color: Colors.transparent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${item.area}${item.city}",
                                        style: TextStyle(color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) async {
                                await SharedPreferenceSingleTon.setData(
                                    "dashboard_branch_id", value.toString());
                                setState(() {
                                  branchdropdownvalue = value;

                                  dashboardcontroller.getDashboard(
                                      dateRange, value.toString(), "month");
                                });
                              },
                            ),
                          )),
                        ),
                        const SizedBox(height: 16),
                        MembersDataScreen(
                            dateRange: dateRange,
                            membersdata: controller.membersData),
                        const SizedBox(height: 16),
                        EnvironmentSavedWidget(
                          dateRange: dateRange,
                          environmentSaving: controller.environmentSaved,
                        ),
                        const SizedBox(height: 16),
                        Statistics(
                          dateRange: dateRange,
                          wastecollected:
                              controller.drywet_Waste_collected.toString(),
                        ),
                        if (controller.lastUpdatedOn != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, right: 16, bottom: 8),
                                child: Center(
                                  child: Text(
                                    "last updated at ${DateFormat("hh:mm").format(controller.lastUpdatedOn!)}",
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )),
      );
    });
  }
}

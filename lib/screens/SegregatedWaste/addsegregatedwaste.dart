import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/controllers/segragated_wastecontroller.dart';

import '../../data/shared_preference.dart';

class addsegregationdetails extends StatefulWidget {
  addsegregationdetails({Key? key}) : super(key: key);

  @override
  State<addsegregationdetails> createState() => _addcollectiondetailsState();
}

class _addcollectiondetailsState extends State<addsegregationdetails> {
  DateTime _selectdate = DateTime.now();
  String? _issegregated = "NO";
  String? _iscitizen;

  final SegragatedController segregatedcontroller =
      Get.put(SegragatedController());
  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectdate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectdate) {
      setState(() {
        _selectdate = picked;
      });
    }
    return _selectdate;
  }

  @override
  void initState() {
    segregatedcontroller.getallcitizen();
    getdashboardbranchid();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    log(dbbranchid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SegragatedController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add segregation details",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: controller.showloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "Select Date",
                              style: GoogleFonts.montserrat(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Text(
                                        DateFormat("yyyy-MM-dd")
                                            .format(_selectdate),
                                        style: GoogleFonts.montserrat(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Is Segregated",
                        style: GoogleFonts.montserrat(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          child: Center(
                        child: DropdownButton(
                          value: _issegregated,
                          underline: SizedBox(),
                          style: GoogleFonts.montserrat(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Is Segregated",
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items: ["YES", "NO"].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${item}",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${item}",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.transparent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            _issegregated = value.toString();
                            setState(() {});
                          },
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Select Citizen",
                        style: GoogleFonts.montserrat(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          child: Center(
                        child: DropdownButton(
                          value: _iscitizen,
                          underline: SizedBox(),
                          style: GoogleFonts.montserrat(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select Citizen",
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items: segregatedcontroller.getallcitizenlist!.data!
                              .map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${item.name}",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${item.id}",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.transparent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${item.phoneNum}",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            _iscitizen = value.toString();
                            setState(() {});
                          },
                        ),
                      )),
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_iscitizen != null) {
                            String selectdate =
                                DateFormat("yyyy-MM-dd").format(_selectdate);
                            String citizenid = _iscitizen.toString();
                            String segregatedvalue =
                                _issegregated == "YES" ? "1" : "0";
                            segregatedcontroller
                                .addsegregationdetails(
                              citizenid: citizenid,
                              issegregated: segregatedvalue,
                              transactiondate: selectdate,
                            )
                                .then((value) {
                              if (value == true) {
                                Get.snackbar(
                                    "Segregation", "Data Saved Successfully",
                                    backgroundColor: Colors.green.shade900,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                                _iscitizen = null;
                                _issegregated = "NO";
                              } else {
                                Get.snackbar("Error", "Data Not Saved",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                              }
                              setState(() {});
                            });
                          } else {
                            Get.snackbar("Segregation", "Please Select Citizen",
                                backgroundColor: Colors.green.shade900,
                                colorText: Colors.white,
                                borderColor: Colors.white,
                                borderWidth: 1);
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}

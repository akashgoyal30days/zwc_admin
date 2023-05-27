import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/controllers/Stock_transfer_controller.dart';
import 'package:zwc/screens/StockTransfer/Add_stock_transfer_wastedetails.dart';

import '../../data/shared_preference.dart';

class Addstockytransferdetails extends StatefulWidget {
  Addstockytransferdetails({Key? key}) : super(key: key);

  @override
  State<Addstockytransferdetails> createState() => _addcollectiondetailsState();
}

class _addcollectiondetailsState extends State<Addstockytransferdetails> {
  DateTime _selectdate = DateTime.now();
  String? branchdropdownvalue;

  final StockTransferController stocktranfercontroller =
      Get.put(StockTransferController());
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
    stocktranfercontroller.getallbranches();
    getdashboardbranchid();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockTransferController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Stock Transfer Details",
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
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Select Branch",
                        style: GoogleFonts.montserrat(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                          child: Center(
                        child: DropdownButton(
                          value: branchdropdownvalue,
                          underline: SizedBox(),
                          style: GoogleFonts.montserrat(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select Branch",
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items: stocktranfercontroller.getallbranchdata!.data!
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
                                        "${item.branchName}",
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
                                    "${item.area}${item.city}",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            branchdropdownvalue = value;
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
                          if (branchdropdownvalue != null) {
                            String selectdate =
                                DateFormat("yyyy-MM-dd").format(_selectdate);
                            String transferbranchid =
                                branchdropdownvalue.toString();
                            Get.to(Addstocktransferwastedetails(
                                selecteddate: selectdate,
                                selecttobranch: transferbranchid));

                            Get.deleteAll();
                          } else {
                            Get.snackbar("Collection", "Please Select Citizen",
                                backgroundColor: Colors.green.shade900,
                                colorText: Colors.white,
                                borderColor: Colors.white,
                                borderWidth: 1);
                          }
                        },
                        child: const Text("Proceed"),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}

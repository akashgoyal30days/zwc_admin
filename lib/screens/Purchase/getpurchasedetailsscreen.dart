import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/controllers/purchasecontroller.dart';
import 'package:zwc/screens/Purchase/GetpurchaseViewDeatils.dart';
import 'package:zwc/widgets/progressloader.dart';

import '../../data/shared_preference.dart';

class GetpurchasedetailsScreen extends StatefulWidget {
  GetpurchasedetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GetpurchasedetailsScreen> createState() =>
      _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<GetpurchasedetailsScreen> {
  final PurchaseController purchasecontroller = Get.put(PurchaseController());

  String? FromDate = "From Date";
  String? ToDate = "To Date";
  final TextEditingController FromController = TextEditingController();
  final TextEditingController ToController = TextEditingController();

  @override
  void initState() {
    getdashboardbranchid();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  DateTime fromdate = DateTime.now();
  Future<DateTime?> selectfromdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromdate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fromdate) {
      setState(() {
        fromdate = picked;
        FromDate = DateFormat("yyyy-MM-dd").format(fromdate);
      });
    }
    return fromdate;
  }

  DateTime todate = DateTime.now();
  Future<DateTime?> selecttodate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: todate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != todate) {
      setState(() {
        todate = picked;
        ToDate = DateFormat("yyyy-MM-dd").format(todate);
      });
    }
    return todate;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Get Purchase Details",
            style: GoogleFonts.roboto(
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  selectfromdate(context);
                                },
                                readOnly: true,
                                controller: FromController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: FromDate,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  selecttodate(context);
                                },
                                readOnly: true,
                                controller: ToController,
                                decoration: InputDecoration(
                                    hintText: ToDate,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
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
                            String lfromdate =
                                DateFormat("yyyy-MM-dd").format(fromdate);
                            String ltodate =
                                DateFormat("yyyy-MM-dd").format(todate);

                            if (todate == null) {
                              Get.snackbar(
                                  "Stock Details", "Please Select Date",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            } else {
                              purchasecontroller.getpurchaselist(
                                  fromdate: lfromdate, todate: ltodate);
                            }
                          },
                          child: const Text("Get Details"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      purchasecontroller.getallpurchaselist == null
                          ? SizedBox()
                          : Column(
                              children: [
                                Container(
                                  height: 500,
                                  child: RawScrollbar(
                                    thumbColor: Colors.green,
                                    trackVisibility: true,
                                    thumbVisibility: true,
                                    child: ListView.builder(
                                      itemCount: purchasecontroller
                                          .getallpurchaselist!.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.green),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          elevation: 5,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Date",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          controller
                                                              .getallpurchaselist!
                                                              .data![index]
                                                              .tdate
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "From Branch",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(controller
                                                            .getallpurchaselist!
                                                            .data![index]
                                                            .fromBranch
                                                            .toString()),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "To Branch",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(controller
                                                            .getallpurchaselist!
                                                            .data![index]
                                                            .toBranch
                                                            .toString()),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Transaction amount",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "₹${controller.getallpurchaselist!.data![index].transactionAmount.toString()}",
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(),
                                                        Visibility(
                                                          visible: true,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Progressloaders
                                                                  .progressloaderdailog(
                                                                      context);

                                                              purchasecontroller
                                                                  .getpurchasedetailsbyid(
                                                                      docid: purchasecontroller
                                                                          .getallpurchaselist!
                                                                          .data![
                                                                              index]
                                                                          .id
                                                                          .toString())
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            Get.back(),
                                                                            Get.to(GetpurchaseViewDetailsScreen())
                                                                          });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Text(
                                                                  "View Details",
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

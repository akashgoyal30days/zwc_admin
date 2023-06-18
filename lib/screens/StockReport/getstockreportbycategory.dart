import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/controllers/stockreportcontroller.dart';

import '../../data/shared_preference.dart';

class GetstockreportbyCategoryScreen extends StatefulWidget {
  GetstockreportbyCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GetstockreportbyCategoryScreen> createState() =>
      _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState
    extends State<GetstockreportbyCategoryScreen> {
  final StockReportController stockcontroller =
      Get.put(StockReportController());

  String? selectcategorydropdownvalue;

  String? FromDate = "From Date";
  String? ToDate = "To Date";
  final TextEditingController FromController = TextEditingController();
  final TextEditingController ToController = TextEditingController();
  List<categorymodel> CategoryList = [
    categorymodel(category: "Dry Waste", id: "1"),
    categorymodel(category: "Wet Waste", id: "2"),
    categorymodel(category: "Sanitary Waste", id: "3")
  ];

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
        lastDate: DateTime.now());
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
        lastDate: DateTime.now());
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
    return GetBuilder<StockReportController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Get Category Stock Report",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Select Category",
                          style: GoogleFonts.roboto(
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
                            value: selectcategorydropdownvalue,
                            underline: SizedBox(),
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            hint: Text(
                              "Select Category",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            items: CategoryList.map((item) {
                              return DropdownMenuItem(
                                value: item.id,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${item.category}",
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
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                selectcategorydropdownvalue = value;
                              });
                            },
                          ),
                        )),
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
                              Get.snackbar("Stock Report", "Please Select Date",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            } else {
                              stockcontroller.getstockreportbycategory(
                                  category: selectcategorydropdownvalue,
                                  fromdate: lfromdate,
                                  todate: ltodate);
                            }
                          },
                          child: const Text("Get Details"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      stockcontroller.getstockdatabycategory == null
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
                                      itemCount: stockcontroller
                                          .getstockdatabycategory!.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          color: index.isOdd
                                              ? Colors.white
                                              : Colors.grey.shade300,
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
                                                        "Category",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        controller
                                                            .getstockdatabycategory!
                                                            .data![index]
                                                            .categoryName
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Opening",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        controller
                                                            .getstockdatabycategory!
                                                            .data![index]
                                                            .opening
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Collection",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        controller
                                                            .getstockdatabycategory!
                                                            .data![index]
                                                            .inQuantity
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Disposed/Recycled",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        controller
                                                            .getstockdatabycategory!
                                                            .data![index]
                                                            .outQuantity
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Balance",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        controller
                                                            .getstockdatabycategory!
                                                            .data![index]
                                                            .balance
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
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

class categorymodel {
  final String? category;
  final String? id;
  categorymodel({this.category, this.id});
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/resourcemanagemntcontroller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/ResouceManagement/wasteproduct/addwasteproduct.dart';

class GetAllProducts extends StatefulWidget {
  GetAllProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<GetAllProducts> createState() => _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<GetAllProducts> {
  final ResourceManagementController rcontroller =
      Get.put(ResourceManagementController());

  @override
  void initState() {
    getdashboardbranchid();
    rcontroller.getallproductlistt();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResourceManagementController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              onPressed: () {
                Get.deleteAll();
                Get.to(AddWasteProduct());
              },
              child: const Text("Add Waste Product"),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Waste Product Details",
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
                      SizedBox(
                        height: 5,
                      ),
                      rcontroller.getallproductlist == null
                          ? SizedBox()
                          : Column(
                              children: [
                                Text(
                                  "Waste Product Details",
                                  style: GoogleFonts.roboto(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 500,
                                  child: RawScrollbar(
                                    thumbColor: Colors.green,
                                    trackVisibility: true,
                                    thumbVisibility: true,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 10,
                                      ),
                                      itemCount: rcontroller
                                          .getallproductlist!.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                                          controller
                                                              .getallproductlist!
                                                              .data![index]
                                                              .productName
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .getallproductlist!
                                                              .data![index]
                                                              .category
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Unit",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .getallproductlist!
                                                              .data![index]
                                                              .unit
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Sale Price",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .getallproductlist!
                                                              .data![index]
                                                              .salePrice
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Purchase Price",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .getallproductlist!
                                                              .data![index]
                                                              .purchasePrice
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "GST",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${controller.getallproductlist!.data![index].gst.toString()}%",
                                                        ),
                                                      ],
                                                    ),
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

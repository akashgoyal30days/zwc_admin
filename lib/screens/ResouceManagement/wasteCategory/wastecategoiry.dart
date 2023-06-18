import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/api/urls.dart';
import 'package:zwc/controllers/resourcemanagemntcontroller.dart';
import 'package:zwc/screens/ResouceManagement/wasteCategory/addwastecategory.dart';

import '../../../data/shared_preference.dart';

class Getwastecategorydata extends StatefulWidget {
  Getwastecategorydata({
    Key? key,
  }) : super(key: key);

  @override
  State<Getwastecategorydata> createState() =>
      _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<Getwastecategorydata> {
  final ResourceManagementController resoucecontroller =
      Get.put(ResourceManagementController());

  @override
  void initState() {
    getdashboardbranchid();
    resoucecontroller.getallwastecategorylist();
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
                Get.to(AddWasteCategoryDetails());
              },
              child: const Text("Add Waste Category"),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Waste Category Details",
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
                      resoucecontroller.getallwastecategoeydata == null
                          ? SizedBox()
                          : Column(
                              children: [
                                Text(
                                  "Waste Category",
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
                                    child: ListView.builder(
                                      itemCount: resoucecontroller
                                          .getallwastecategoeydata!
                                          .data!
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          color: Colors.white,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              child: Card(
                                                elevation: 10,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        child: Image.network(
                                                          URLS.baseURL +
                                                              controller
                                                                  .getallwastecategoeydata!
                                                                  .data![index]
                                                                  .categoryImage
                                                                  .toString(),
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                controller
                                                                    .getallwastecategoeydata!
                                                                    .data![
                                                                        index]
                                                                    .categoryName
                                                                    .toString(),
                                                                style: GoogleFonts.roboto(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                                controller
                                                                    .getallwastecategoeydata!
                                                                    .data![
                                                                        index]
                                                                    .parent
                                                                    .toString(),
                                                                style: GoogleFonts.roboto(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
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

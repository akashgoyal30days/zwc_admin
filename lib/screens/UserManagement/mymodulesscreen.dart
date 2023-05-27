import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/usermanagemntconrollewer.dart';

import '../../data/shared_preference.dart';

class MyModeulesScreen extends StatefulWidget {
  MyModeulesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyModeulesScreen> createState() => _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<MyModeulesScreen> {
  final UserManagementController usermanagemntcontroller =
      Get.put(UserManagementController());

  @override
  void initState() {
    getdashboardbranchid();
    usermanagemntcontroller.getmymodulesdetsils();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserManagementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Modules",
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Active",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Not Acive",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      usermanagemntcontroller.getmymodulesdata == null
                          ? SizedBox()
                          : Container(
                              color: Colors.green,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Text(
                                        "Modules",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "Add",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Edit",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "View",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Delete",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      usermanagemntcontroller.getmymodulesdata == null
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
                                      itemCount: usermanagemntcontroller
                                          .getmymodulesdata!.data!.length,
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.20,
                                                    child: Text(
                                                      controller
                                                          .getmymodulesdata!
                                                          .data![index]
                                                          .name
                                                          .toString(),
                                                      maxLines: 3,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        color: controller
                                                                    .getmymodulesdata!
                                                                    .data![
                                                                        index]
                                                                    .isAdd
                                                                    .toString() ==
                                                                "1"
                                                            ? Colors.green
                                                            : Colors.red,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        color: controller
                                                                    .getmymodulesdata!
                                                                    .data![
                                                                        index]
                                                                    .isEdit
                                                                    .toString() ==
                                                                "1"
                                                            ? Colors.green
                                                            : Colors.red,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        color: controller
                                                                    .getmymodulesdata!
                                                                    .data![
                                                                        index]
                                                                    .isView
                                                                    .toString() ==
                                                                "1"
                                                            ? Colors.green
                                                            : Colors.red,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        color: controller
                                                                    .getmymodulesdata!
                                                                    .data![
                                                                        index]
                                                                    .isDelete
                                                                    .toString() ==
                                                                "1"
                                                            ? Colors.green
                                                            : Colors.red,
                                                        shape: BoxShape.circle),
                                                  )
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

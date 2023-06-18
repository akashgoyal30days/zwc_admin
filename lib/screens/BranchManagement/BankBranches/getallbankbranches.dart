import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/Branchcontroller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/BranchManagement/BankBranches/addbankbranches.dart';

class Getallbankbranches extends StatefulWidget {
  Getallbankbranches({
    Key? key,
  }) : super(key: key);

  @override
  State<Getallbankbranches> createState() => _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<Getallbankbranches> {
  final Branchcontroller bcontroller = Get.put(Branchcontroller());

  @override
  void initState() {
    getdashboardbranchid();
    bcontroller.getallbankbranches();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Branchcontroller>(builder: (controller) {
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
                Get.to(addbankbranches());
              },
              child: const Text("Add Bank Branch"),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Bank Branches",
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
                      bcontroller.getallbankbrancheslist == null
                          ? SizedBox()
                          : Column(
                              children: [
                                Text(
                                  "Bank Branches",
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
                                      itemCount: bcontroller
                                          .getallbankbrancheslist!.data!.length,
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
                                                      Expanded(
                                                        child: Text(
                                                          controller
                                                              .getallbankbrancheslist!
                                                              .data![index]
                                                              .branchName
                                                              .toString(),
                                                        ),
                                                      ),
                                                      Text(controller
                                                          .getallbankbrancheslist!
                                                          .data![index]
                                                          .branchType
                                                          .toString()),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text("Contact"),
                                                      ),
                                                      Text(controller
                                                          .getallbankbrancheslist!
                                                          .data![index]
                                                          .branchContact
                                                          .toString()),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            "Email Address"),
                                                      ),
                                                      Text(controller
                                                          .getallbankbrancheslist!
                                                          .data![index]
                                                          .branchEmail
                                                          .toString()),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(controller
                                                              .getallbankbrancheslist!
                                                              .data![index]
                                                              .area
                                                              .toString() +
                                                          " " +
                                                          controller
                                                              .getallbankbrancheslist!
                                                              .data![index]
                                                              .city
                                                              .toString() +
                                                          " " +
                                                          controller
                                                              .getallbankbrancheslist!
                                                              .data![index]
                                                              .state
                                                              .toString()),
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

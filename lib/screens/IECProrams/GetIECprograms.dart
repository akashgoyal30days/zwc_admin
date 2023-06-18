import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/IECProgramController.dart';
import 'package:zwc/screens/IECProrams/addprogram_iecprogram.dart';
import 'package:zwc/screens/IECProrams/viewprogramdetails_iecprogram.dart';
import 'package:zwc/widgets/progressloader.dart';

import '../../data/shared_preference.dart';

class GetIECProgramsDetails extends StatefulWidget {
  GetIECProgramsDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<GetIECProgramsDetails> createState() =>
      _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<GetIECProgramsDetails> {
  final IECProgramController ieccontroller = Get.put(IECProgramController());

  @override
  void initState() {
    getdashboardbranchid();
    ieccontroller.getalliecprograms();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IECProgramController>(builder: (controller) {
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
                Get.to(AddIECProgramScreen());
              },
              child: const Text("Add Program"),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "IEC Program Details",
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
                      ieccontroller.getalliecprogramlist == null
                          ? SizedBox()
                          : Column(
                              children: [
                                Text(
                                  "IEC Programs",
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
                                      itemCount: ieccontroller
                                          .getalliecprogramlist!.data!.length,
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
                                                      Text(controller
                                                          .getalliecprogramlist!
                                                          .data![index]
                                                          .programName
                                                          .toString()),
                                                      Visibility(
                                                        visible: true,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Progressloaders
                                                                .progressloaderdailog(
                                                                    context);

                                                            ieccontroller
                                                                .gettopicsbyprogramid(
                                                                    ieccontroller
                                                                        .getalliecprogramlist!
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString())
                                                                .then(
                                                                    (value) => {
                                                                          Get.back(),
                                                                          Get.to(
                                                                              ViewIECProgramsDetails(
                                                                            programid:
                                                                                ieccontroller.getalliecprogramlist!.data![index].id.toString(),
                                                                          ))
                                                                        });
                                                          },
                                                          child: Text(
                                                            "View Topics",
                                                            style: GoogleFonts.roboto(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          ),
                                                        ),
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

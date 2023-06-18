import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/IECProgramController.dart';
import 'package:zwc/screens/IECProrams/addtopic_iecprogram.dart';

import '../../data/shared_preference.dart';

class ViewIECProgramsDetails extends StatefulWidget {
  final String? programid;
  ViewIECProgramsDetails({
    Key? key,
    required this.programid,
  }) : super(key: key);

  @override
  State<ViewIECProgramsDetails> createState() =>
      _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<ViewIECProgramsDetails> {
  final IECProgramController ieccontroller = Get.put(IECProgramController());

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
                Get.to(AddIECProgramTopicScreen(
                  programid: widget.programid.toString(),
                ));
              },
              child: const Text("Add Topic"),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "IEC Program Topic Details",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    ieccontroller.getiecprogramstopicsdata == null
                        ? SizedBox()
                        : Column(
                            children: [
                              Text(
                                "IEC Program Topics",
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
                                        .getiecprogramstopicsdata!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        color: index.isOdd
                                            ? Colors.white
                                            : Colors.grey.shade300,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(controller
                                                        .getiecprogramstopicsdata!
                                                        .data![index]
                                                        .programName
                                                        .toString()),
                                                    SizedBox(
                                                      width: 40,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        controller
                                                            .getiecprogramstopicsdata!
                                                            .data![index]
                                                            .topicName
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
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
      );
    });
  }
}

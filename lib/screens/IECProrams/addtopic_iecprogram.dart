import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/IECProgramController.dart';
import 'package:zwc/screens/IECProrams/GetIECprograms.dart';
import 'package:zwc/widgets/progressloader.dart';

import '../../data/shared_preference.dart';

class AddIECProgramTopicScreen extends StatefulWidget {
  final String? programid;
  AddIECProgramTopicScreen({
    Key? key,
    required this.programid,
  }) : super(key: key);

  @override
  State<AddIECProgramTopicScreen> createState() => _addwastedetailsState();
}

class _addwastedetailsState extends State<AddIECProgramTopicScreen> {
  final IECProgramController ieccontroller = Get.put(IECProgramController());

  String? topichint = "Topic Name";
  final TextEditingController topiccontroller = TextEditingController();

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
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add IEC Program Topic",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Enter IEC Program Topic Name",
                        style: GoogleFonts.roboto(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
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
                              controller: topiccontroller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: topichint,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.90,
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
                              if (topiccontroller.text.isNotEmpty) {
                                Progressloaders.progressloaderdailog(context);
                                ieccontroller
                                    .addiecprogramtopics(
                                        widget.programid.toString(),
                                        topiccontroller.text.toString())
                                    .then((value) => {
                                          if (value!.status.toString() ==
                                              "true")
                                            {
                                              Get.back(),
                                              Get.snackbar(
                                                  "IEC Program", "Topic Added!",
                                                  backgroundColor: Colors.blue,
                                                  colorText: Colors.white,
                                                  borderColor: Colors.white,
                                                  borderWidth: 1),
                                              topiccontroller.clear(),
                                              Get.deleteAll(),
                                              Get.to(GetIECProgramsDetails())
                                            }
                                        });
                              } else {
                                Get.snackbar(
                                    "IEC Program", "Please Enter Topic",
                                    backgroundColor: Colors.red,
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
                  ],
                ),
              ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/Branchcontroller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/BranchManagement/Branchestypes/getallbranchestypes.dart';
import 'package:zwc/widgets/progressloader.dart';

class addbranchestypes extends StatefulWidget {
  addbranchestypes({
    Key? key,
  }) : super(key: key);

  @override
  State<addbranchestypes> createState() => _addwastedetailsState();
}

class _addwastedetailsState extends State<addbranchestypes> {
  final Branchcontroller bcontroller = Get.put(Branchcontroller());

  String? namehint = "Name";
  String? adf1hint = "Additional field1";
  String? adf2hint = "Additional field2";
  String? adf3hint = "Additional field3";
  String? adf4hint = "Additional field4";
  String? adf5hint = "Additional field5";
  String? adf6hint = "Additional field6";
  String? adf7hint = "Additional field7";
  String? adf8hint = "Additional field8";
  String? adf9hint = "Additional field9";
  String? adf10hint = "Additional field10";

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController ad1 = TextEditingController();
  final TextEditingController ad2 = TextEditingController();
  final TextEditingController ad3 = TextEditingController();
  final TextEditingController ad4 = TextEditingController();
  final TextEditingController ad5 = TextEditingController();
  final TextEditingController ad6 = TextEditingController();
  final TextEditingController ad7 = TextEditingController();
  final TextEditingController ad8 = TextEditingController();
  final TextEditingController ad9 = TextEditingController();
  final TextEditingController ad10 = TextEditingController();

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
                if (namecontroller.text.isNotEmpty) {
                  Progressloaders.progressloaderdailog(context);
                  bcontroller
                      .addbranchtype(
                        branchname: namecontroller.text.toString(),
                        ad1: ad1.text.toString(),
                        ad2: ad1.text.toString(),
                        ad3: ad3.text.toString(),
                        ad4: ad4.text.toString(),
                        ad5: ad5.text.toString(),
                        ad6: ad6.text.toString(),
                        ad7: ad7.text.toString(),
                        ad8: ad8.text.toString(),
                        ad9: ad9.text.toString(),
                        ad10: ad10.text.toString(),
                      )
                      .then((value) => {
                            if (value!.status.toString() == "true")
                              {
                                Get.back(),
                                Get.snackbar(
                                    "Branch Type", "Branch Type Added!",
                                    backgroundColor: Colors.blue,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1),
                                Get.deleteAll(),
                                Get.to(GetBranchestypesDetails())
                              }
                          });
                } else {
                  Get.snackbar("Branch Type", "Please Enter Name",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      borderColor: Colors.white,
                      borderWidth: 1);
                }
              },
              child: const Text("Add Branch Types"),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Branch type",
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
            : ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Name",
                      style: GoogleFonts.roboto(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: namecontroller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: namehint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Additional Fields",
                      style: GoogleFonts.roboto(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad1,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf1hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad2,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf2hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad3,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf3hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad4,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf4hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad5,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf5hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad6,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf6hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad7,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf7hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad8,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf8hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad9,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf9hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ad10,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: adf10hint,
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}

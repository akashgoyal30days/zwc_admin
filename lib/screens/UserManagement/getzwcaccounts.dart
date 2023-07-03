import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/controllers/usermanagemntconrollewer.dart';
import 'package:zwc/model/Getallcitizenlistmodel.dart';
import 'package:zwc/screens/CollectionManagement/Add_Collection_waste_details.dart';
import 'package:zwc/screens/dashboard/certificate.dart';
import 'package:zwc/widgets/progressloader.dart';

import '../../data/shared_preference.dart';

class GetZwcAccountsScreen extends StatefulWidget {
  GetZwcAccountsScreen({Key? key}) : super(key: key);

  @override
  State<GetZwcAccountsScreen> createState() => _addcollectiondetailsState();
}

class _addcollectiondetailsState extends State<GetZwcAccountsScreen> {
  DateTime _selectdate = DateTime.now();
  bool? _isdonation = false;
  String? _iscitizen;

  final UserManagementController usermanagemntcontroller =
      Get.put(UserManagementController());
  final TextEditingController citizencontroller = TextEditingController();

  List<Data> fileteredcictizenlist = [];

  @override
  void initState() {
    usermanagemntcontroller.getallcitizen().then((value) => {setcitizen()});
    getdashboardbranchid();
    super.initState();
  }

  setcitizen() {
    fileteredcictizenlist =
        usermanagemntcontroller.getallcitizenlist!.data!.toList();
    setState(() {});
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
  }

  void filterItems(String query) {
    fileteredcictizenlist.clear();
    if (query.isNotEmpty) {
      usermanagemntcontroller.getallcitizenlist!.data!.forEach((element) {
        if (element.name
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()) ||
            element.phoneNum
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()) ||
            element.ad1
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()) ||
            element.ad2
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()) ||
            element.ad3
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()) ||
            element.ad4
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase())) {
          fileteredcictizenlist.add(element);
        }
      });
    } else {
      fileteredcictizenlist
          .addAll(usermanagemntcontroller.getallcitizenlist!.data!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserManagementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "ZWC Accounts",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: citizencontroller,
                        onChanged: (value) {
                          filterItems(value.toString());
                        },
                        decoration: InputDecoration(
                          hintText:
                              "Search by name or phone no or additional fields",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: RawScrollbar(
                            thumbColor: Colors.green,
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                              itemCount: fileteredcictizenlist.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    _iscitizen = fileteredcictizenlist[index]
                                        .id
                                        .toString();
                                    setState(() {});
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Name",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    fileteredcictizenlist[index]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Contact No",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    fileteredcictizenlist[index]
                                                        .phoneNum
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Email",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    fileteredcictizenlist[index]
                                                        .email
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                            .getallcitizenlist!
                                                            .additional!
                                                            .first
                                                            .ad1 ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    fileteredcictizenlist[index]
                                                                .ad1
                                                                .toString() ==
                                                            ""
                                                        ? ""
                                                        : " ${fileteredcictizenlist[index].ad1 ?? ""}",
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                            .getallcitizenlist!
                                                            .additional!
                                                            .first
                                                            .ad2 ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    fileteredcictizenlist[index]
                                                                .ad2
                                                                .toString() ==
                                                            ""
                                                        ? ""
                                                        : " ${fileteredcictizenlist[index].ad2 ?? ""}",
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                            .getallcitizenlist!
                                                            .additional!
                                                            .first
                                                            .ad3 ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    fileteredcictizenlist[index]
                                                                .ad3
                                                                .toString() ==
                                                            ""
                                                        ? ""
                                                        : " ${fileteredcictizenlist[index].ad3 ?? ""}",
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                            .getallcitizenlist!
                                                            .additional!
                                                            .first
                                                            .ad4 ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    fileteredcictizenlist[index]
                                                                .ad4
                                                                .toString() ==
                                                            ""
                                                        ? ""
                                                        : " ${fileteredcictizenlist[index].ad4 ?? ""}",
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Address",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      fileteredcictizenlist[
                                                              index]
                                                          .address
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      color:
                                                          Colors.green.shade800,
                                                      height: 30,
                                                      child: Center(
                                                          child: Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 2,
                                                    color: Colors.white,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      color:
                                                          Colors.green.shade800,
                                                      height: 30,
                                                      child: Center(
                                                          child: Text(
                                                        "Update Password",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 2,
                                                    color: Colors.white,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Progressloaders
                                                            .progressloaderdailog(
                                                                context);
                                                        usermanagemntcontroller
                                                            .getuserCertificate(
                                                                uid: fileteredcictizenlist[
                                                                        index]
                                                                    .id
                                                                    .toString())
                                                            .then((value) => {
                                                                  Navigator.pop(
                                                                      context),
                                                                  Get.to(
                                                                      CertificateScreen(
                                                                    value,
                                                                    username: fileteredcictizenlist[
                                                                            index]
                                                                        .name
                                                                        .toString(),
                                                                  ))
                                                                });
                                                      },
                                                      child: Container(
                                                        color: Colors
                                                            .green.shade800,
                                                        height: 30,
                                                        child: Center(
                                                            child: Text(
                                                          "View Certificate",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.green,
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
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
                          if (_iscitizen != null) {
                            String selectdate =
                                DateFormat("yyyy-MM-dd").format(_selectdate);
                            String citizenid = _iscitizen.toString();
                            String donationvalue =
                                _isdonation == true ? "1" : "0";
                            Get.deleteAll();
                            Get.to(AddCollectionWasteDetails(
                              selecteddate: selectdate,
                              citizenid: citizenid,
                              isdonation: donationvalue,
                            ));
                          } else {
                            Get.snackbar("Collection", "Please Select Citizen",
                                backgroundColor: Colors.green.shade900,
                                colorText: Colors.white,
                                borderColor: Colors.white,
                                borderWidth: 1);
                          }
                        },
                        child: const Text("Proceed"),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}

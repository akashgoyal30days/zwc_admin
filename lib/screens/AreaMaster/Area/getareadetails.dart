import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/areamastercontroller.dart';
import 'package:zwc/data/shared_preference.dart';

class GetAreaDetails extends StatefulWidget {
  GetAreaDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<GetAreaDetails> createState() => _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<GetAreaDetails> {
  final AreaMasterController areamastercontroller =
      Get.put(AreaMasterController());

  final TextEditingController editareacontroller = TextEditingController();

  final TextEditingController adddareacontroller = TextEditingController();

  String? selectedstate;
  String? selecteddistrict;
  String? selectedcity;
  String? selectedatrea;

  @override
  void initState() {
    getdashboardbranchid();
    areamastercontroller.getallstatesslist();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  editareadetailspopup(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: editareacontroller,
                    decoration: InputDecoration(
                      labelText: 'Edit Area Name',
                      border: OutlineInputBorder(),
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
                        areamastercontroller
                            .editareadetails(
                                cityid: selectedcity,
                                areaid: selectedatrea,
                                areaname: editareacontroller.text.toString())
                            .then((value) => {
                                  Get.back(),
                                  if (value!.status == true)
                                    {
                                      Get.snackbar(
                                          "Area Details", "Details Updated",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      areamastercontroller.getareadtabycityid(
                                          cityid: selectedcity)
                                    }
                                  else
                                    {
                                      Get.snackbar(
                                          "Area Details", "Details Not Updated",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1)
                                    }
                                });
                      },
                      child: const Text("Update Detail"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  addareadetailsdetailspopup(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: adddareacontroller,
                    decoration: InputDecoration(
                      labelText: 'Add Area',
                      border: OutlineInputBorder(),
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
                        areamastercontroller
                            .addareadetails(
                                cityid: selectedcity,
                                areaname: adddareacontroller.text.toString())
                            .then((value) => {
                                  Get.back(),
                                  if (value!.status == true)
                                    {
                                      Get.snackbar(
                                          "Area Details", "Details Added",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      areamastercontroller.getareadtabycityid(
                                          cityid: selectedcity)
                                    }
                                  else
                                    {
                                      Get.snackbar(
                                          "Area Details", "Details Not Added",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1)
                                    }
                                });
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AreaMasterController>(builder: (controller) {
      return Scaffold(
        floatingActionButton: selecteddistrict == null
            ? SizedBox()
            : FloatingActionButton.extended(
                onPressed: () {
                  addareadetailsdetailspopup(context);
                },
                label: Text("Add Area")),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Get Area Details",
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
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                            child: Center(
                          child: DropdownButton(
                            value: selectedstate,
                            underline: SizedBox(),
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            hint: Text(
                              "Select State",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            items:
                                controller.getallstateslist!.data!.map((item) {
                              return DropdownMenuItem(
                                value: item.id,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${item.name}",
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
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                selectedstate = value;
                                selecteddistrict = null;
                                selectedcity = null;
                              });
                              controller.getdistrictdetailsbystate(
                                  stateid: selectedstate);
                            },
                          ),
                        )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      controller.getdistrictdata == null
                          ? SizedBox()
                          : Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                  child: Center(
                                child: DropdownButton(
                                  value: selecteddistrict,
                                  underline: SizedBox(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  hint: Text(
                                    "Select District",
                                    style: GoogleFonts.roboto(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  items: controller.getdistrictdata!.data!
                                      .map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${item.name}",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${item.id}",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.transparent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) async {
                                    setState(() {
                                      selecteddistrict = value;
                                      areamastercontroller
                                          .getcitydatabydistrict(
                                              districtid:
                                                  selecteddistrict.toString());
                                    });
                                  },
                                ),
                              )),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      controller.getcitydata == null
                          ? SizedBox()
                          : Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                  child: Center(
                                child: DropdownButton(
                                  value: selectedcity,
                                  underline: SizedBox(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  hint: Text(
                                    "Select city",
                                    style: GoogleFonts.roboto(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  items:
                                      controller.getcitydata!.data!.map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${item.name}",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${item.id}",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.transparent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) async {
                                    setState(() {
                                      selectedcity = value;
                                    });
                                  },
                                ),
                              )),
                            ),
                      SizedBox(
                        height: 5,
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
                            if (selectedstate == null) {
                              Get.snackbar(
                                  "Area Deatils", "Please Select State",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            } else {
                              if (selecteddistrict == null) {
                                Get.snackbar(
                                    "Area Details", "Please Select District",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                              } else {
                                controller.getareadtabycityid(
                                    cityid: selectedcity);
                              }
                            }
                          },
                          child: const Text("Get Details"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      areamastercontroller.getareadata == null
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
                                      itemCount: areamastercontroller
                                          .getareadata!.data!.length,
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
                                                          .getareadata!
                                                          .data![index]
                                                          .name
                                                          .toString()),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            editareacontroller
                                                                    .text =
                                                                controller
                                                                    .getareadata!
                                                                    .data![
                                                                        index]
                                                                    .name
                                                                    .toString();
                                                            selectedatrea =
                                                                controller
                                                                    .getareadata!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString();
                                                          });
                                                          editareadetailspopup(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Edit Details",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
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

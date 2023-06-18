import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/areamastercontroller.dart';
import 'package:zwc/data/shared_preference.dart';

class GetCityDetails extends StatefulWidget {
  GetCityDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<GetCityDetails> createState() => _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<GetCityDetails> {
  final AreaMasterController areamastercontroller =
      Get.put(AreaMasterController());

  final TextEditingController editcitycontroller = TextEditingController();
  final TextEditingController editpincodecontroller = TextEditingController();

  final TextEditingController adddcitycontroller = TextEditingController();
  final TextEditingController addpincodecontroller = TextEditingController();

  String? selectedstate;
  String? selecteddistrict;
  String? selectedcity;

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

  editcitydetailspopup(BuildContext context) {
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
                    controller: editcitycontroller,
                    decoration: InputDecoration(
                      labelText: 'Edit City Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: editpincodecontroller,
                    decoration: InputDecoration(
                      labelText: 'Edit Pinocde',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
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
                            .editcitydetails(
                                cityid: selectedcity,
                                districtid: selecteddistrict,
                                cityname: editcitycontroller.text.toString(),
                                pincode: editpincodecontroller.text.toString())
                            .then((value) => {
                                  Get.back(),
                                  if (value!.status == true)
                                    {
                                      Get.snackbar(
                                          "City Details", "Details Updated",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      areamastercontroller
                                          .getcitydatabydistrict(
                                              districtid: selecteddistrict)
                                    }
                                  else
                                    {
                                      Get.snackbar(
                                          "City Details", "Details Not Updated",
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

  addcitydetailspopup(BuildContext context) {
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
                    controller: adddcitycontroller,
                    decoration: InputDecoration(
                      labelText: 'Add City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: addpincodecontroller,
                    decoration: InputDecoration(
                      labelText: 'Edit Pinocde',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
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
                            .addcitydetails(
                                districtid: selecteddistrict,
                                cityname: adddcitycontroller.text.toString(),
                                pinocde: addpincodecontroller.text.toString())
                            .then((value) => {
                                  Get.back(),
                                  if (value!.status == true)
                                    {
                                      Get.snackbar(
                                          "District Details", "Details Added",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      areamastercontroller
                                          .getcitydatabydistrict(
                                              districtid: selecteddistrict)
                                    }
                                  else
                                    {
                                      Get.snackbar("District Details",
                                          "Details Not Added",
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
                  addcitydetailspopup(context);
                },
                label: Text("Add City")),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Get City Details",
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
                                controller.getcitydatabydistrict(
                                    districtid: selecteddistrict);
                              }
                            }
                          },
                          child: const Text("Get Details"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      areamastercontroller.getcitydata == null
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
                                          .getcitydata!.data!.length,
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
                                                          .getcitydata!
                                                          .data![index]
                                                          .name
                                                          .toString()),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedcity =
                                                                controller
                                                                    .getcitydata!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString();
                                                            editcitycontroller
                                                                    .text =
                                                                controller
                                                                    .getcitydata!
                                                                    .data![
                                                                        index]
                                                                    .name
                                                                    .toString();
                                                          });
                                                          editcitydetailspopup(
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/areamastercontroller.dart';
import 'package:zwc/data/shared_preference.dart';

class GetDistrictDetails extends StatefulWidget {
  GetDistrictDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<GetDistrictDetails> createState() => _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<GetDistrictDetails> {
  final AreaMasterController areamastercontroller =
      Get.put(AreaMasterController());

  final TextEditingController editdistrictcontroller = TextEditingController();

  final TextEditingController adddistrictcontroller = TextEditingController();

  String? selectedstate;
  String? selecteddistrict;

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

  editdistrictdetailspopup(BuildContext context) {
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
                    controller: editdistrictcontroller,
                    decoration: InputDecoration(
                      labelText: 'Edit District Name',
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
                            .editdistrictdetails(
                                stateid: selectedstate,
                                districtid: selecteddistrict,
                                districtname:
                                    editdistrictcontroller.text.toString())
                            .then((value) => {
                                  Get.back(),
                                  if (value!.status == true)
                                    {
                                      Get.snackbar(
                                          "District Details", "Details Updated",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      areamastercontroller
                                          .getdistrictdetailsbystate(
                                              stateid: selectedstate)
                                    }
                                  else
                                    {
                                      Get.snackbar("District Details",
                                          "Details Not Updated",
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

  adddistrictdetailspopup(BuildContext context) {
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
                    controller: adddistrictcontroller,
                    decoration: InputDecoration(
                      labelText: 'Add District',
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
                            .adddistrictdetails(
                                stateid: selectedstate,
                                districtname:
                                    adddistrictcontroller.text.toString())
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
                                          .getdistrictdetailsbystate(
                                              stateid: selectedstate)
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
        floatingActionButton: selectedstate == null
            ? SizedBox()
            : FloatingActionButton.extended(
                onPressed: () {
                  adddistrictdetailspopup(context);
                },
                label: Text("Add District")),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Get District Details",
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
                              });
                            },
                          ),
                        )),
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
                            if (selectedstate == null) {
                              Get.snackbar(
                                  "District Details", "Please Select State",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            } else {
                              areamastercontroller.getdistrictdetailsbystate(
                                  stateid: selectedstate.toString());
                            }
                          },
                          child: const Text("Get Details"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      areamastercontroller.getdistrictdata == null
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
                                          .getdistrictdata!.data!.length,
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
                                                          .getdistrictdata!
                                                          .data![index]
                                                          .name
                                                          .toString()),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            editdistrictcontroller
                                                                    .text =
                                                                controller
                                                                    .getdistrictdata!
                                                                    .data![
                                                                        index]
                                                                    .name
                                                                    .toString();
                                                            selecteddistrict =
                                                                controller
                                                                    .getdistrictdata!
                                                                    .data![
                                                                        index]
                                                                    .id;
                                                          });
                                                          editdistrictdetailspopup(
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

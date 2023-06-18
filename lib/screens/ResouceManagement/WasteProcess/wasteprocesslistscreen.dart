import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/resourcemanagemntcontroller.dart';
import 'package:zwc/data/shared_preference.dart';

class GetWasteProcessDetails extends StatefulWidget {
  GetWasteProcessDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<GetWasteProcessDetails> createState() =>
      _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<GetWasteProcessDetails> {
  final ResourceManagementController rcontroller =
      Get.put(ResourceManagementController());

  final TextEditingController editprocesscontroller = TextEditingController();
  final TextEditingController editsolutioncontroller = TextEditingController();

  final TextEditingController addprocesscontroller = TextEditingController();
  final TextEditingController addsolutioncontroller = TextEditingController();

  String? selectedstate;
  String? selectedprocessid;

  @override
  void initState() {
    getdashboardbranchid();
    rcontroller.getallwasteprocesses();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  editpeocessdetailspopup(BuildContext context) {
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
                    controller: editprocesscontroller,
                    decoration: InputDecoration(
                      labelText: 'Edit Process Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: editsolutioncontroller,
                    decoration: InputDecoration(
                      labelText: 'Edit Solution Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
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
                        rcontroller
                            .editwasteprocesssdetails(
                                machinename:
                                    editsolutioncontroller.text.toString(),
                                processid: selectedprocessid,
                                processname:
                                    editprocesscontroller.text.toString())
                            .then((value) => {
                                  Get.back(),
                                  if (value!.status == true)
                                    {
                                      Get.snackbar("Waste Process Details",
                                          "Details Updated",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      rcontroller.getallwasteprocesses()
                                    }
                                  else
                                    {
                                      Get.snackbar("Waste Process Details",
                                          "Details Not Updated",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
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

  addprocessdetailspopup(BuildContext context) {
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
                    controller: addprocesscontroller,
                    decoration: InputDecoration(
                      labelText: 'Add Process Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: addsolutioncontroller,
                    decoration: InputDecoration(
                      labelText: 'Add Solution Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
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
                        rcontroller
                            .addwasteprocesssdetails(
                                processname:
                                    addprocesscontroller.text.toString(),
                                machinename:
                                    addsolutioncontroller.text.toString())
                            .then((value) => {
                                  Get.back(),
                                  if (value!.status == true)
                                    {
                                      Get.snackbar("Waste Process Details",
                                          "Details Added",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      rcontroller.getallwasteprocesses()
                                    }
                                  else
                                    {
                                      Get.snackbar(
                                          "Waste Process", "Details Not Added",
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
    return GetBuilder<ResourceManagementController>(builder: (controller) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              addprocessdetailspopup(context);
            },
            label: Text("Add Waste Process")),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Waste Processes Details",
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
                      rcontroller.getallwasteprocess == null
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
                                      itemCount: rcontroller
                                          .getallwasteprocess!.data!.length,
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
                                                          .getallwasteprocess!
                                                          .data![index]
                                                          .processName
                                                          .toString()),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(controller
                                                          .getallwasteprocess!
                                                          .data![index]
                                                          .machineName
                                                          .toString()),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            editprocesscontroller
                                                                    .text =
                                                                controller
                                                                    .getallwasteprocess!
                                                                    .data![
                                                                        index]
                                                                    .processName
                                                                    .toString();
                                                            editsolutioncontroller
                                                                    .text =
                                                                controller
                                                                    .getallwasteprocess!
                                                                    .data![
                                                                        index]
                                                                    .machineName
                                                                    .toString();
                                                            selectedprocessid =
                                                                controller
                                                                    .getallwasteprocess!
                                                                    .data![
                                                                        index]
                                                                    .id;
                                                          });
                                                          editpeocessdetailspopup(
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

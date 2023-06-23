import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/controllers/collection_management_controller.dart';
import 'package:zwc/model/Getallcitizenlistmodel.dart';
import 'package:zwc/screens/CollectionManagement/Add_Collection_waste_details.dart';

import '../../data/shared_preference.dart';

class addcollectiondetails extends StatefulWidget {
  addcollectiondetails({Key? key}) : super(key: key);

  @override
  State<addcollectiondetails> createState() => _addcollectiondetailsState();
}

class _addcollectiondetailsState extends State<addcollectiondetails> {
  DateTime _selectdate = DateTime.now();
  bool? _isdonation = false;
  String? _iscitizen;

  final CollectionManagementController collectioncontroller =
      Get.put(CollectionManagementController());
  final TextEditingController citizencontroller = TextEditingController();

  List<Data> fileteredcictizenlist = [];
  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectdate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectdate) {
      setState(() {
        _selectdate = picked;
      });
    }
    return _selectdate;
  }

  @override
  void initState() {
    collectioncontroller.getallcitizen().then((value) => {setcitizen()});
    getdashboardbranchid();
    super.initState();
  }

  setcitizen() {
    fileteredcictizenlist =
        collectioncontroller.getallcitizenlist!.data!.toList();
    setState(() {});
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
  }

  void filterItems(String query) {
    fileteredcictizenlist.clear();
    if (query.isNotEmpty) {
      collectioncontroller.getallcitizenlist!.data!.forEach((element) {
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
                .contains(query.toString().toLowerCase())) {
          fileteredcictizenlist.add(element);
        }
      });
    } else {
      fileteredcictizenlist
          .addAll(collectioncontroller.getallcitizenlist!.data!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionManagementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Collection",
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
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "Select Date",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Text(
                                        DateFormat("yyyy-MM-dd")
                                            .format(_selectdate),
                                        style: GoogleFonts.roboto(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Is Donation",
                        style: GoogleFonts.roboto(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Card(
                        child: CheckboxListTile(
                          title: Text(
                            "Is Donation?",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          value: _isdonation,
                          onChanged: (newValue) {
                            _isdonation = newValue;
                            setState(() {});
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Select Citizen",
                        style: GoogleFonts.roboto(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: citizencontroller,
                        onChanged: (value) {
                          filterItems(value.toString());
                        },
                        decoration: InputDecoration(
                          labelText: 'Search Citizen',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          color: Colors.grey.shade200,
                          child: RawScrollbar(
                            thumbColor: Colors.green,
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: ListView.builder(
                              itemCount: fileteredcictizenlist.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    citizencontroller.text =
                                        fileteredcictizenlist[index]
                                            .name
                                            .toString();

                                    _iscitizen = fileteredcictizenlist[index]
                                        .id
                                        .toString();
                                    setState(() {});
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${fileteredcictizenlist[index].name.toString()}"
                                              "(${fileteredcictizenlist[index].phoneNum.toString()})"),
                                          Text(
                                            fileteredcictizenlist[index]
                                                        .ad1
                                                        .toString() ==
                                                    ""
                                                ? ""
                                                : "${fileteredcictizenlist[index].ad1.toString()}",
                                            style: TextStyle(
                                                color: Colors.black45),
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

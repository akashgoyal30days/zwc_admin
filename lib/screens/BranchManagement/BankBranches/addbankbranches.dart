import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/Branchcontroller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/BranchManagement/BankBranches/getallbankbranches.dart';
import 'package:zwc/widgets/progressloader.dart';

class addbankbranches extends StatefulWidget {
  addbankbranches({
    Key? key,
  }) : super(key: key);

  @override
  State<addbankbranches> createState() => _GetCollectionDetailsScreenState();
}

class _GetCollectionDetailsScreenState extends State<addbankbranches> {
  final Branchcontroller bcontroller = Get.put(Branchcontroller());
  String? selectredbranchtype;
  String? selectedstate;
  String? selecteddistrict;
  String? selectedcity;
  String? selectedatrea;

  String? bnamehint = "Branch name";
  String? bcontacthint = "Branch Contact";
  String? bemailhint = "Branch Email";
  String? badresshint = "Branch Address";

  bool? saleavailablevalue = false;
  bool? purchaseavailable = false;
  bool? Collectionrequestavailable = false;
  bool? depositavailable = false;
  bool? stocktransferavailable = false;
  bool? wasteprocessingavailbale = false;

  final TextEditingController bnamecontroller = TextEditingController();
  final TextEditingController bcontactcontroller = TextEditingController();
  final TextEditingController bemailcontroller = TextEditingController();
  final TextEditingController baddresscontroller = TextEditingController();

  @override
  void initState() {
    getdashboardbranchid();
    bcontroller.getallbranchestypes();
    bcontroller.getallstatesslist();
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
                if (bnamecontroller.text.isNotEmpty) {
                  if (bcontactcontroller.text.isNotEmpty) {
                    if (bemailcontroller.text.isNotEmpty) {
                      if (selectredbranchtype.toString() != "null") {
                        Progressloaders.progressloaderdailog(context);
                        bcontroller
                            .addbankbranch(
                              areaid: selectedatrea.toString(),
                              branchaddresss:
                                  baddresscontroller.text.toString(),
                              branchcontact: bcontactcontroller.text.toString(),
                              branchemail: bemailcontroller.text.toString(),
                              branchname: bnamecontroller.text.toString(),
                              branchtypeid: selectredbranchtype.toString(),
                              issale: saleavailablevalue == true ? "1" : "0",
                              iscollectionreq:
                                  Collectionrequestavailable == true
                                      ? "1"
                                      : "0",
                              isdepoist: depositavailable == true ? "1" : "0",
                              ispurchase: purchaseavailable == true ? "1" : "0",
                              isstocktransfer:
                                  stocktransferavailable == true ? "1" : "0",
                              iswasteprocessing:
                                  wasteprocessingavailbale == true ? "1" : "0",
                            )
                            .then((value) => {
                                  if (value!.status.toString() == "true")
                                    {
                                      Get.back(),
                                      Get.snackbar(
                                          "Branch Type", "Branch Added!",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1),
                                      Get.deleteAll(),
                                      Get.to(Getallbankbranches())
                                    }
                                });
                      } else {
                        Get.snackbar("Branch", "Please select branch type",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            borderColor: Colors.white,
                            borderWidth: 1);
                      }
                    } else {
                      Get.snackbar("Branch", "Please Enter Email",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          borderColor: Colors.white,
                          borderWidth: 1);
                    }
                  } else {
                    Get.snackbar("Branch", "Please Enter Contact",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        borderColor: Colors.white,
                        borderWidth: 1);
                  }
                } else {
                  Get.snackbar("Branch", "Please Enter Name",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      borderColor: Colors.white,
                      borderWidth: 1);
                }
              },
              child: const Text("Add Bank Branch"),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Bank Branches",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Branch name *",
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
                                controller: bnamecontroller,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintText: bnamehint,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Branch Contact *",
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
                                controller: bcontactcontroller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: bcontacthint,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Branch Email *",
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
                                controller: bemailcontroller,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintText: bemailhint,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Branch Address",
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
                                controller: baddresscontroller,
                                maxLines: 3,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintText: badresshint,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Select Branch Type *",
                          style: GoogleFonts.roboto(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                            child: Center(
                          child: DropdownButton(
                            value: selectredbranchtype,
                            underline: SizedBox(),
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            hint: Text(
                              "Select Branch Type",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            items: controller.getallbranchestypelist!.data!
                                .map((item) {
                              return DropdownMenuItem(
                                value: item.id,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${item.branchType}",
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
                              selectredbranchtype = value;
                              setState(() {});
                            },
                          ),
                        )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Select State",
                          style: GoogleFonts.roboto(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
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
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "Select District",
                                style: GoogleFonts.roboto(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
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
                                      bcontroller.getcitydatabydistrict(
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
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "Select City",
                                style: GoogleFonts.roboto(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
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
                                      controller.getareadtabycityid(
                                          cityid: selectedcity);
                                    });
                                  },
                                ),
                              )),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      controller.getareadata == null
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "Select Area",
                                style: GoogleFonts.roboto(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                      controller.getareadata == null
                          ? SizedBox()
                          : Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                  child: Center(
                                child: DropdownButton(
                                  value: selectedatrea,
                                  underline: SizedBox(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  hint: Text(
                                    "Select Area",
                                    style: GoogleFonts.roboto(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  items:
                                      controller.getareadata!.data!.map((item) {
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
                                      selectedatrea = value;
                                    });
                                  },
                                ),
                              )),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: CheckboxListTile(
                            title: Text(
                              "Sale Available?",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: saleavailablevalue,
                            onChanged: (newValue) {
                              saleavailablevalue = newValue;
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: CheckboxListTile(
                            title: Text(
                              "Purchase Available?",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: purchaseavailable,
                            onChanged: (newValue) {
                              purchaseavailable = newValue;
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: CheckboxListTile(
                            title: Text(
                              "Collection Request?",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: Collectionrequestavailable,
                            onChanged: (newValue) {
                              Collectionrequestavailable = newValue;
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: CheckboxListTile(
                            title: Text(
                              "Deposit Available?",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: depositavailable,
                            onChanged: (newValue) {
                              depositavailable = newValue;
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: CheckboxListTile(
                            title: Text(
                              "Stock Transfer Available?",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: stocktransferavailable,
                            onChanged: (newValue) {
                              stocktransferavailable = newValue;
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: CheckboxListTile(
                            title: Text(
                              "Waste Processing Available?",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: wasteprocessingavailbale,
                            onChanged: (newValue) {
                              wasteprocessingavailbale = newValue;
                              setState(() {});
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

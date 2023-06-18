import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/collection_management_controller.dart';
import 'package:zwc/model/addwastedetailsmoodel.dart';
import 'package:zwc/screens/CollectionManagement/Add_collection_details.dart';

import '../../data/shared_preference.dart';

class AddCollectionWasteDetails extends StatefulWidget {
  final String? selecteddate;
  final String? isdonation;
  final String? citizenid;
  AddCollectionWasteDetails(
      {Key? key,
      required this.selecteddate,
      required this.isdonation,
      required this.citizenid})
      : super(key: key);

  @override
  State<AddCollectionWasteDetails> createState() => _addwastedetailsState();
}

class _addwastedetailsState extends State<AddCollectionWasteDetails> {
  final CollectionManagementController collectioncontroller =
      Get.put(CollectionManagementController());

  String? selectwastedropdownvalue;
  String? quantityhinttext = "Quantity";
  String? Rateshinttext = "Rates";
  final TextEditingController quantitycontroller = TextEditingController();
  final TextEditingController ratescontroller = TextEditingController();
  List<AddWasteDetailsModel> WasteDetailsData = [];

  @override
  void initState() {
    collectioncontroller.getallproductlistt();
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
    return GetBuilder<CollectionManagementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Waste Details",
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
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Select Waste",
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
                            value: selectwastedropdownvalue,
                            underline: SizedBox(),
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            hint: Text(
                              "Select Waste",
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            items:
                                controller.getallproductlist!.data!.map((item) {
                              return DropdownMenuItem(
                                value: item.id,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${item.productName})",
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
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "(${item.category})",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                selectwastedropdownvalue = value;
                                quantityhinttext = controller
                                    .getallproductlist!.data!
                                    .where((element) =>
                                        element.id.toString() ==
                                        value.toString())
                                    .first
                                    .unit
                                    .toString();
                                ratescontroller.text = controller
                                    .getallproductlist!.data!
                                    .where((element) =>
                                        element.id.toString() ==
                                        value.toString())
                                    .first
                                    .salePrice
                                    .toString();
                              });
                            },
                          ),
                        )),
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
                                controller: quantitycontroller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: quantityhinttext,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: ratescontroller,
                                decoration: InputDecoration(
                                    hintText: Rateshinttext,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
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
                            if (ratescontroller.text.isNotEmpty) {
                              if (quantitycontroller.text.isNotEmpty) {
                                if (selectwastedropdownvalue != null) {
                                  WasteDetailsData.add(AddWasteDetailsModel(
                                      Date: widget.selecteddate,
                                      Citizenid: widget.citizenid,
                                      Isdonation: widget.isdonation,
                                      Productid: selectwastedropdownvalue,
                                      Productname: collectioncontroller
                                          .getallproductlist!.data!
                                          .where((element) =>
                                              element.id.toString() ==
                                              selectwastedropdownvalue
                                                  .toString())
                                          .first
                                          .productName
                                          .toString(),
                                      Quantity: quantitycontroller.text,
                                      Rates: ratescontroller.text));
                                  setState(() {});
                                } else {
                                  Get.snackbar("Add Waste Details",
                                      "Please Select Waste",
                                      backgroundColor: Colors.green.shade900,
                                      colorText: Colors.white,
                                      borderColor: Colors.white,
                                      borderWidth: 1);
                                }
                              } else {
                                Get.snackbar("Add Waste Details",
                                    "Please Enter Quantity",
                                    backgroundColor: Colors.green.shade900,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                              }
                            } else {
                              Get.snackbar(
                                  "Add Waste Details", "Please Enter Rate",
                                  backgroundColor: Colors.green.shade900,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            }
                          },
                          child: const Text("Add"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.green,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Quantity",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rates",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Total",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Action",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 400,
                        child: RawScrollbar(
                          thumbColor: Colors.green,
                          trackVisibility: true,
                          thumbVisibility: true,
                          child: ListView.builder(
                            itemCount: WasteDetailsData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: index.isOdd
                                    ? Colors.white
                                    : Colors.grey.shade300,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(WasteDetailsData[index]
                                          .Productname
                                          .toString()),
                                      Text(WasteDetailsData[index]
                                          .Quantity
                                          .toString()),
                                      Text(WasteDetailsData[index]
                                          .Rates
                                          .toString()),
                                      Text((int.parse(WasteDetailsData[index]
                                                  .Quantity
                                                  .toString()) *
                                              double.parse(
                                                  WasteDetailsData[index]
                                                      .Rates
                                                      .toString()))
                                          .toString()),
                                      InkWell(
                                          onTap: () {
                                            WasteDetailsData.removeAt(index);
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
                            if (WasteDetailsData.isNotEmpty) {
                              controller
                                  .uploadwastedata(WasteDetailsData)
                                  .then((value) => {
                                        if (value == true)
                                          {
                                            Get.snackbar("Waste Data",
                                                "Data Added Successfully!",
                                                backgroundColor: Colors.blue,
                                                colorText: Colors.white,
                                                borderColor: Colors.white,
                                                borderWidth: 1),
                                            selectwastedropdownvalue = null,
                                            WasteDetailsData.clear(),
                                            quantitycontroller.clear(),
                                            ratescontroller.clear(),
                                            setState(() {}),
                                            Get.to(addcollectiondetails())
                                          }
                                        else
                                          {
                                            Get.snackbar(
                                                "Waste Data", "Data Not Added!",
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                                borderColor: Colors.white,
                                                borderWidth: 1),
                                          }
                                      });
                            } else {
                              Get.snackbar("Waste Data", "Please Add some Data",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            }
                          },
                          child: const Text("Upload"),
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

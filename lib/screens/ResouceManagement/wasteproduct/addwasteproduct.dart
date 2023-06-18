import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/resourcemanagemntcontroller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/ResouceManagement/wasteproduct/getallwasteproducts.dart';
import 'package:zwc/widgets/progressloader.dart';

class AddWasteProduct extends StatefulWidget {
  AddWasteProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<AddWasteProduct> createState() => _addwastedetailsState();
}

class _addwastedetailsState extends State<AddWasteProduct> {
  final ResourceManagementController rcontroller =
      Get.put(ResourceManagementController());

  String? producthint = "Product name";
  String? salespricehint = "Sales price";
  String? purchasepricehint = "Purchase price";
  String? selectedparentcategory;
  String? selectedparentcategoryfinal;
  String? selectedwastetypeid;
  String? selectedproductunitid;
  String? selectedgstid;

  final TextEditingController productnamecontroller = TextEditingController();
  final TextEditingController salescontroller = TextEditingController();
  final TextEditingController purchasecontroller = TextEditingController();

  @override
  void initState() {
    getdashboardbranchid();
    rcontroller.getallwastecategorylist();
    rcontroller.getproductswastetype();
    rcontroller.getproductunitlistt();
    rcontroller.getallgstslabs();

    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResourceManagementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Waste Product",
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Select category",
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
                          value: selectedparentcategory,
                          underline: SizedBox(),
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select Parent Category",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items: controller.getallwastecategoeydata!.data!
                              .map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${item.categoryName}",
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
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedparentcategory = value.toString();
                              selectedparentcategoryfinal = controller
                                  .getallwastecategoeydata!.data!
                                  .where((element) =>
                                      element.id.toString() == value.toString())
                                  .first
                                  .parentCategory
                                  .toString();
                            });
                            log(value.toString());
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
                        "Product Name",
                        style: GoogleFonts.roboto(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: productnamecontroller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: producthint,
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
                        "Sales Price",
                        style: GoogleFonts.roboto(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: salescontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: salespricehint,
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
                        "Purchase Price",
                        style: GoogleFonts.roboto(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: purchasecontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: purchasepricehint,
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
                        "Select Waste type",
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
                          value: selectedwastetypeid,
                          underline: SizedBox(),
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select Waste type",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items: controller.getproductwastetypedata!.data!
                              .map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${item.waste}",
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
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedwastetypeid = value.toString();
                            });
                            log(value.toString());
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
                        "Select UOM",
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
                          value: selectedproductunitid,
                          underline: SizedBox(),
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select UOM",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items:
                              controller.getproductunitlist!.data!.map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${item.unit}",
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
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedproductunitid = value.toString();
                            });
                            log(value.toString());
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
                        "Select GST",
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
                          value: selectedgstid,
                          underline: SizedBox(),
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select GST",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items:
                              controller.getproductgstslabs!.data!.map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${item.gst}",
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
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedgstid = value.toString();
                            });
                            log(value.toString());
                          },
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
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
                              if (productnamecontroller.text.isNotEmpty) {
                                if (selectedparentcategoryfinal.toString() !=
                                    "null") {
                                  if (salescontroller.text.isNotEmpty) {
                                    if (purchasecontroller.text.isNotEmpty) {
                                      if (selectedwastetypeid.toString() !=
                                          "null") {
                                        if (selectedproductunitid.toString() !=
                                            "null") {
                                          if (selectedgstid.toString() !=
                                              "null") {
                                            Progressloaders
                                                .progressloaderdailog(context);
                                            rcontroller
                                                .addwasteproduct(
                                                  categoryid:
                                                      selectedparentcategoryfinal
                                                          .toString(),
                                                  gstid:
                                                      selectedgstid.toString(),
                                                  productname:
                                                      productnamecontroller.text
                                                          .toString(),
                                                  purchaseprice:
                                                      purchasecontroller.text
                                                          .toString(),
                                                  salesprice: salescontroller
                                                      .text
                                                      .toString(),
                                                  uintid: selectedproductunitid
                                                      .toString(),
                                                  wastetypeid:
                                                      selectedwastetypeid
                                                          .toString(),
                                                )
                                                .then((value) => {
                                                      if (value!.status
                                                              .toString() ==
                                                          "true")
                                                        {
                                                          Get.back(),
                                                          Get.snackbar(
                                                              "Waste Product",
                                                              "Product Added!",
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              colorText:
                                                                  Colors.white,
                                                              borderColor:
                                                                  Colors.white,
                                                              borderWidth: 1),
                                                          Get.deleteAll(),
                                                          Get.to(
                                                              GetAllProducts())
                                                        }
                                                    });
                                          } else {
                                            Get.snackbar("Waste Product",
                                                "Please select GST",
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                                borderColor: Colors.white,
                                                borderWidth: 1);
                                          }
                                        } else {
                                          Get.snackbar("Waste Product",
                                              "Please select unit",
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              borderColor: Colors.white,
                                              borderWidth: 1);
                                        }
                                      } else {
                                        Get.snackbar("Waste Product",
                                            "Please select waste type",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            borderColor: Colors.white,
                                            borderWidth: 1);
                                      }
                                    } else {
                                      Get.snackbar("Waste Product",
                                          "Please Enter Purchase price",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          borderColor: Colors.white,
                                          borderWidth: 1);
                                    }
                                  } else {
                                    Get.snackbar("Waste Product",
                                        "Please Enter Sales price",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        borderColor: Colors.white,
                                        borderWidth: 1);
                                  }
                                } else {
                                  Get.snackbar("Waste Product",
                                      "Please select parent category",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      borderColor: Colors.white,
                                      borderWidth: 1);
                                }
                              } else {
                                Get.snackbar("Waste Product",
                                    "Please Enter Product Name",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                              }
                            },
                            child: const Text("Add Product"),
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

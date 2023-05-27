import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/waste_processing_controller.dart';
import 'package:zwc/model/addconsumptiondetailsproductdetails.dart';
import 'package:zwc/screens/WasteProcessing/addwasteprocessing.dart';

import '../../data/shared_preference.dart';

class ConsumptionGeneratdProductDeatils extends StatefulWidget {
  final String? selecteddate;
  final String? wasteprocess;
  ConsumptionGeneratdProductDeatils(
      {Key? key, required this.selecteddate, required this.wasteprocess})
      : super(key: key);

  @override
  State<ConsumptionGeneratdProductDeatils> createState() =>
      _addwastedetailsState();
}

class _addwastedetailsState extends State<ConsumptionGeneratdProductDeatils> {
  final WasteProcessingController wastecontroller =
      Get.put(WasteProcessingController());

  String? selectwastedropdownvalue1;
  String? quantityhinttext1 = "Quantity";
  final TextEditingController quantitycontroller1 = TextEditingController();
  String? selectwastedropdownvalue2;
  String? quantityhinttext2 = "Quantity";
  final TextEditingController quantitycontroller2 = TextEditingController();
  List<AddConsumptionDetails> consumptiondetaildata = [];
  List<AddGeneratedProductDetails> generatedproductdata = [];

  @override
  void initState() {
    wastecontroller.getallproductlistt();
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
    return GetBuilder<WasteProcessingController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Consumption & Product Details",
            style: GoogleFonts.montserrat(
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
                          "Add Consumption Details",
                          style: GoogleFonts.montserrat(
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
                            value: selectwastedropdownvalue1,
                            underline: SizedBox(),
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            hint: Text(
                              "Select Waste",
                              style: GoogleFonts.montserrat(
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
                                          style: GoogleFonts.montserrat(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${item.id}",
                                          style: GoogleFonts.montserrat(
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
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                selectwastedropdownvalue1 = value;
                                quantityhinttext1 = controller
                                    .getallproductlist!.data!
                                    .where((element) =>
                                        element.id.toString() ==
                                        selectwastedropdownvalue1.toString())
                                    .first
                                    .unit
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
                                controller: quantitycontroller1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: quantityhinttext1,
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
                            if (quantitycontroller1.text.isNotEmpty) {
                              if (selectwastedropdownvalue1 != null) {
                                consumptiondetaildata.add(AddConsumptionDetails(
                                  Date: widget.selecteddate,
                                  Productid: selectwastedropdownvalue1,
                                  Productname: wastecontroller
                                      .getallproductlist!.data!
                                      .where((element) =>
                                          element.id.toString() ==
                                          selectwastedropdownvalue1.toString())
                                      .first
                                      .productName
                                      .toString(),
                                  Quantity: quantitycontroller1.text.toString(),
                                  wasteprocess: widget.wasteprocess.toString(),
                                ));

                                setState(() {});
                              } else {
                                Get.snackbar("Consumption Detsils",
                                    "Please Select Waste",
                                    backgroundColor: Colors.green.shade900,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                              }
                            } else {
                              Get.snackbar("Consumption Details",
                                  "Please Enter Quantity",
                                  backgroundColor: Colors.green.shade900,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            }
                          },
                          child: const Text("Add Consumption Details"),
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
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Quantity",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Action",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: RawScrollbar(
                          thumbColor: Colors.green,
                          trackVisibility: true,
                          thumbVisibility: true,
                          child: ListView.builder(
                            itemCount: consumptiondetaildata.length,
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
                                      Text(consumptiondetaildata[index]
                                          .Productname
                                          .toString()),
                                      Text(consumptiondetaildata[index]
                                          .Quantity
                                          .toString()),
                                      InkWell(
                                          onTap: () {
                                            consumptiondetaildata
                                                .removeAt(index);
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
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Add Generated Product Details",
                          style: GoogleFonts.montserrat(
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
                            value: selectwastedropdownvalue2,
                            underline: SizedBox(),
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            hint: Text(
                              "Select Waste",
                              style: GoogleFonts.montserrat(
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
                                          style: GoogleFonts.montserrat(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${item.id}",
                                          style: GoogleFonts.montserrat(
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
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                selectwastedropdownvalue2 = value;
                                quantityhinttext2 = controller
                                    .getallproductlist!.data!
                                    .where((element) =>
                                        element.id.toString() ==
                                        value.toString())
                                    .first
                                    .unit
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
                                controller: quantitycontroller2,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: quantityhinttext2,
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
                            if (quantitycontroller2.text.isNotEmpty) {
                              if (selectwastedropdownvalue2 != null) {
                                generatedproductdata
                                    .add(AddGeneratedProductDetails(
                                  Date: widget.selecteddate,
                                  Productid: selectwastedropdownvalue2,
                                  Productname: wastecontroller
                                      .getallproductlist!.data!
                                      .where((element) =>
                                          element.id.toString() ==
                                          selectwastedropdownvalue2.toString())
                                      .first
                                      .productName
                                      .toString(),
                                  Quantity: quantitycontroller2.text.toString(),
                                  wasteprocess: widget.wasteprocess.toString(),
                                ));

                                setState(() {});
                              } else {
                                Get.snackbar(
                                    "Generated Product", "Please Select Waste",
                                    backgroundColor: Colors.green.shade900,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                              }
                            } else {
                              Get.snackbar(
                                  "Generatd Product", "Please Enter Quantity",
                                  backgroundColor: Colors.green.shade900,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            }
                          },
                          child: const Text("Add Product Details"),
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
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Quantity",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Action",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: RawScrollbar(
                          thumbColor: Colors.green,
                          trackVisibility: true,
                          thumbVisibility: true,
                          child: ListView.builder(
                            itemCount: generatedproductdata.length,
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
                                      Text(generatedproductdata[index]
                                          .Productname
                                          .toString()),
                                      Text(generatedproductdata[index]
                                          .Quantity
                                          .toString()),
                                      InkWell(
                                          onTap: () {
                                            generatedproductdata
                                                .removeAt(index);
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
                            if (generatedproductdata.isNotEmpty &&
                                consumptiondetaildata.isNotEmpty) {
                              controller
                                  .uploadwasteprocessingdata(
                                      consumptiondetaildata,
                                      generatedproductdata,
                                      widget.wasteprocess.toString())
                                  .then((value) => {
                                        if (value == true)
                                          {
                                            Get.snackbar(
                                                "Waste Processing Data",
                                                "Data Added Successfully!",
                                                backgroundColor: Colors.blue,
                                                colorText: Colors.white,
                                                borderColor: Colors.white,
                                                borderWidth: 1),
                                            selectwastedropdownvalue1 = null,
                                            selectwastedropdownvalue2 = null,
                                            quantitycontroller1.clear(),
                                            quantitycontroller2.clear(),
                                            setState(() {}),
                                            Get.deleteAll(),
                                            Get.to(addwasteprocessing())
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
                              Get.snackbar("Consumption & Product",
                                  "Please Add some Data",
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/waste_processing_controller.dart';

class WasteProcessingViewDetailsScreen extends StatefulWidget {
  WasteProcessingViewDetailsScreen({Key? key}) : super(key: key);

  @override
  State<WasteProcessingViewDetailsScreen> createState() =>
      _CollectionViewDetailsScreenState();
}

class _CollectionViewDetailsScreenState
    extends State<WasteProcessingViewDetailsScreen> {
  final WasteProcessingController wasteProcessingController =
      Get.put(WasteProcessingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Waste Process Details"),
      ),
      body: ListView(
        children: [
          // userdetails
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  border: TableBorder.all(color: Colors.grey.shade200),
                  children: [
                    TableRow(
                      children: [
                        Text("Waste Process",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 18)),
                        Text(
                            wasteProcessingController
                                .getwasteprocessdatabyid!.data!.processName
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 18)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Solution",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 18)),
                        Text(
                            wasteProcessingController
                                .getwasteprocessdatabyid!.data!.machineName
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 18)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Date",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 18)),
                        Text(
                            wasteProcessingController
                                .getwasteprocessdatabyid!.data!.tdate
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //consumed proucts

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Consumed Products",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Table(
                  border: TableBorder.all(color: Colors.grey.shade200),
                  children: [
                    TableRow(
                      children: [
                        Text("Products",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 18)),
                        Text("Quantity",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 18)),
                      ],
                    ),
                    for (var i = 0;
                        i <
                            wasteProcessingController.getwasteprocessdatabyid!
                                .data!.cproducts!.length;
                        i++)
                      TableRow(
                        children: [
                          Text(
                              wasteProcessingController.getwasteprocessdatabyid!
                                  .data!.cproducts![i].productName
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 18)),
                          Text(
                              wasteProcessingController.getwasteprocessdatabyid!
                                  .data!.cproducts![i].quom
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 18)),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          //generated products
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Generated Products",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Table(
                  border: TableBorder.all(color: Colors.grey.shade200),
                  children: [
                    TableRow(
                      children: [
                        Text("Products",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 18)),
                        Text("Quantity",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 18)),
                      ],
                    ),
                    for (var i = 0;
                        i <
                            wasteProcessingController.getwasteprocessdatabyid!
                                .data!.gproducts!.length;
                        i++)
                      TableRow(
                        children: [
                          Text(
                              wasteProcessingController.getwasteprocessdatabyid!
                                  .data!.gproducts![i].productName
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 18)),
                          Text(
                              wasteProcessingController.getwasteprocessdatabyid!
                                  .data!.gproducts![i].quom
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 18)),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

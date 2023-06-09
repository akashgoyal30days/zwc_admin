import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/collection_management_controller.dart';

class CollectionViewDetailsScreen extends StatefulWidget {
  CollectionViewDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionViewDetailsScreen> createState() =>
      _CollectionViewDetailsScreenState();
}

class _CollectionViewDetailsScreenState
    extends State<CollectionViewDetailsScreen> {
  final CollectionManagementController collectioncontroller =
      Get.put(CollectionManagementController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Collection Details"),
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
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("User Details",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
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
                        Text("Name",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.name
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Email",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.email
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Contact",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.phoneNum
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Address",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.address
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //branchdetails
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
                    child: Text("Branch Details",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ),
                Table(
                  border: TableBorder.all(color: Colors.grey.shade200),
                  children: [
                    TableRow(
                      children: [
                        Text("Name",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.branchName
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Email",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.branchEmail
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Contact",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.branchContact
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("Address",
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 16)),
                        Text(
                            collectioncontroller
                                .getcollectiondatabyid!.data!.branchAddress
                                .toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //categorywisecollection
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
                    child: Text("Category Wise Details",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
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
                                color: Colors.black, fontSize: 16)),
                        Text("Quantity",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16)),
                      ],
                    ),
                    for (var i = 0;
                        i <
                            collectioncontroller.getcollectiondatabyid!.data!
                                .categoryWiseCollection!.length;
                        i++)
                      TableRow(
                        children: [
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                  .categoryWiseCollection![i].param
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 16)),
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                  .categoryWiseCollection![i].amount
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          //productscollctionm
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
                    child: Text("Products Details",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
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
                                color: Colors.black, fontSize: 16)),
                        Text("Quantity",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16)),
                        Text("Rates",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16)),
                        Text("Total",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16)),
                      ],
                    ),
                    for (var i = 0;
                        i <
                            collectioncontroller
                                .getcollectiondatabyid!.data!.products!.length;
                        i++)
                      TableRow(
                        children: [
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                  .products![i].productName
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 16)),
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                      .products![i].quom
                                      .toString() +
                                  " " +
                                  collectioncontroller.getcollectiondatabyid!
                                      .data!.products![i].uom
                                      .toString()
                                      .toLowerCase(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 16)),
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                  .products![i].rate
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 16)),
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                      .products![i].totalAmount
                                      .toString() +
                                  " " +
                                  collectioncontroller.getcollectiondatabyid!
                                      .data!.products![i].uom
                                      .toString()
                                      .toLowerCase(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          //environment saveddetails
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
                    child: Text("Environment Saved",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
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
                        Text("Parameter",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16)),
                        Text("Value",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16)),
                      ],
                    ),
                    for (var i = 0;
                        i <
                            collectioncontroller.getcollectiondatabyid!.data!
                                .environmentSaved!.length;
                        i++)
                      TableRow(
                        children: [
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                  .environmentSaved![i].environmentParameter
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 16)),
                          Text(
                              collectioncontroller.getcollectiondatabyid!.data!
                                  .environmentSaved![i].paramAmount
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

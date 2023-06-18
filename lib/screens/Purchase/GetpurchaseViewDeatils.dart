import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/purchasecontroller.dart';

class GetpurchaseViewDetailsScreen extends StatefulWidget {
  GetpurchaseViewDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GetpurchaseViewDetailsScreen> createState() =>
      _CollectionViewDetailsScreenState();
}

class _CollectionViewDetailsScreenState
    extends State<GetpurchaseViewDetailsScreen> {
  final PurchaseController purchaseController = Get.put(PurchaseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Purchase Details"),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text("From Branch",
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontSize: 18)),
                    ),
                    Expanded(
                      child: Text(
                          purchaseController
                              .getpurchasedetailsdatabyid!.data!.fromBranch
                              .toString(),
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 18)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text("To Branch",
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontSize: 18)),
                    ),
                    Expanded(
                      child: Text(
                          purchaseController
                              .getpurchasedetailsdatabyid!.data!.toBranch
                              .toString(),
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 18)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text("Date",
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontSize: 18)),
                    ),
                    Expanded(
                      child: Text(
                          purchaseController
                              .getpurchasedetailsdatabyid!.data!.tdate
                              .toString(),
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 18)),
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
                        Text("Rates",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 18)),
                        Text("Total",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 18)),
                      ],
                    ),
                    for (var i = 0;
                        i <
                            purchaseController.getpurchasedetailsdatabyid!.data!
                                .products!.length;
                        i++)
                      TableRow(
                        children: [
                          Text(
                              purchaseController.getpurchasedetailsdatabyid!
                                  .data!.products![i].productName
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 18)),
                          Text(
                              purchaseController.getpurchasedetailsdatabyid!
                                  .data!.products![i].quom
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 18)),
                          Text(
                              purchaseController.getpurchasedetailsdatabyid!
                                  .data!.products![i].rate
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 18)),
                          Text(
                              purchaseController.getpurchasedetailsdatabyid!
                                  .data!.products![i].totalAmount
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

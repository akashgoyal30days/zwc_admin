import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/controllers/salescpntroller.dart';

class GetSalesViewDetailsScreen extends StatefulWidget {
  GetSalesViewDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GetSalesViewDetailsScreen> createState() =>
      _CollectionViewDetailsScreenState();
}

class _CollectionViewDetailsScreenState
    extends State<GetSalesViewDetailsScreen> {
  final SalesController salescontroller = Get.put(SalesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sales Details"),
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
                              color: Colors.green, fontSize: 16)),
                    ),
                    Expanded(
                      child: Text(
                          salescontroller
                              .getsalesdetailsdatabyid!.data!.fromBranch
                              .toString(),
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 16)),
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
                              color: Colors.green, fontSize: 16)),
                    ),
                    Expanded(
                      child: Text(
                          salescontroller
                              .getsalesdetailsdatabyid!.data!.toBranch
                              .toString(),
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 16)),
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
                              color: Colors.green, fontSize: 16)),
                    ),
                    Expanded(
                      child: Text(
                          salescontroller.getsalesdetailsdatabyid!.data!.tdate
                              .toString(),
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 16)),
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
                            salescontroller.getsalesdetailsdatabyid!.data!
                                .products!.length;
                        i++)
                      TableRow(
                        children: [
                          Text(
                              salescontroller.getsalesdetailsdatabyid!.data!
                                  .products![i].productName
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 16)),
                          Text(
                              salescontroller.getsalesdetailsdatabyid!.data!
                                  .products![i].quom
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 16)),
                          Text(
                              salescontroller.getsalesdetailsdatabyid!.data!
                                  .products![i].rate
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 16)),
                          Text(
                              salescontroller.getsalesdetailsdatabyid!.data!
                                  .products![i].totalAmount
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
        ],
      ),
    );
  }
}

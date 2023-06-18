import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/screens/CollectionManagement/Add_collection_details.dart';
import 'package:zwc/screens/CollectionManagement/Get_collection_details.dart';
import 'package:zwc/screens/Navigation_drawer.dart';
import 'package:zwc/screens/Sales/addsalesdeatils.dart';
import 'package:zwc/screens/Sales/getsalesdetailsscreen.dart';
import 'package:zwc/screens/StockTransfer/Add_stocktransfer_details.dart';
import 'package:zwc/screens/StockTransfer/getstocktransferdetails.dart';

class SalesScreen extends StatefulWidget {
  SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _Collection_managementState();
}

class _Collection_managementState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigationdrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sales",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(GetsalesdetailsScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Get Sales Details",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(Addsalesdetails());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Add Sales Details",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/screens/CollectionManagement/Add_collection_details.dart';
import 'package:zwc/screens/CollectionManagement/Get_collection_details.dart';
import 'package:zwc/screens/Navigation_drawer.dart';
import 'package:zwc/screens/Purchase/addpurchasedetails.dart';
import 'package:zwc/screens/Purchase/getpurchasedetailsscreen.dart';
import 'package:zwc/screens/Sales/addsalesdeatils.dart';
import 'package:zwc/screens/Sales/getsalesdetailsscreen.dart';
import 'package:zwc/screens/StockTransfer/Add_stocktransfer_details.dart';
import 'package:zwc/screens/StockTransfer/getstocktransferdetails.dart';

class PurchaseScreen extends StatefulWidget {
  PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _Collection_managementState();
}

class _Collection_managementState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigationdrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Purchase",
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
              Get.to(GetpurchasedetailsScreen());
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
                        "Get Purchase Details",
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
              Get.to(AddPurchaseDeatils());
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
                        "Add Purchase Details",
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

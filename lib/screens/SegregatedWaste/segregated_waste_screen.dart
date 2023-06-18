import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zwc/screens/Navigation_drawer.dart';
import 'package:zwc/screens/SegregatedWaste/addsegregatedbyQR.dart';
import 'package:zwc/screens/SegregatedWaste/addsegregatedwaste.dart';
import 'package:zwc/screens/SegregatedWaste/getsegregateddetails.dart';
import 'package:zwc/screens/SegregatedWaste/getusersegregatedqr.dart';
import 'package:zwc/screens/StockTransfer/Add_stocktransfer_details.dart';
import 'package:zwc/screens/StockTransfer/getstocktransferdetails.dart';

class SegregatedWasteScreen extends StatefulWidget {
  SegregatedWasteScreen({Key? key}) : super(key: key);

  @override
  State<SegregatedWasteScreen> createState() => _Collection_managementState();
}

class _Collection_managementState extends State<SegregatedWasteScreen> {
  @override
  void initState() {
    askpermission();
    super.initState();
  }

  askpermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigationdrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Segrated Waste",
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
              Get.to(GetSegregatedDetails());
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
                        "Get Segregated Waste Details",
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
              Get.to(addsegregationdetails());
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
                        "Add Segregated Waste Details",
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
              Get.to(AddSegregateByQR());
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
                        "Add Segregated via QR",
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
          // InkWell(
          //   onTap: () {
          //     Get.to(getusersegregatedqrdetails());
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       decoration: BoxDecoration(color: Colors.green),
          //       child: Padding(
          //         padding: const EdgeInsets.all(20.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Get User Segregated QR",
          //               style: GoogleFonts.roboto(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             Icon(
          //               Icons.arrow_forward_ios_rounded,
          //               color: Colors.white,
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

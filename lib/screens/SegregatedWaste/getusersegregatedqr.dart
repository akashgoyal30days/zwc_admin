import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zwc/controllers/segragated_wastecontroller.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/shared_preference.dart';

class getusersegregatedqrdetails extends StatefulWidget {
  getusersegregatedqrdetails({Key? key}) : super(key: key);

  @override
  State<getusersegregatedqrdetails> createState() =>
      _addcollectiondetailsState();
}

class _addcollectiondetailsState extends State<getusersegregatedqrdetails> {
  String? _iscitizen;
  GlobalKey qrglobalKey = GlobalKey();

  final SegragatedController segregatedcontroller =
      Get.put(SegragatedController());

  @override
  void initState() {
    segregatedcontroller.getallcitizen();
    getdashboardbranchid();
    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    log(dbbranchid.toString());
  }

  Future<void> _shareQRCodeImage() async {
    try {
      RenderRepaintBoundary boundary = qrglobalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return _shareQRCodeImage();
      }

      final directory = await getTemporaryDirectory();
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      final filePath = '${directory.path}/qr_code.png';
      File(filePath).writeAsBytesSync(pngBytes);

      await Share.shareFiles([filePath], text: 'Segregated QR code');
    } catch (e) {
      print('Error sharing QR code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SegragatedController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Get User Segreagted QR",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Select Citizen",
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
                          value: _iscitizen,
                          underline: SizedBox(),
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select Citizen",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items: segregatedcontroller.getallcitizenlist!.data!
                              .map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item.name}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${item.phoneNum}",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black45,
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
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            _iscitizen = value.toString();
                            setState(() {});
                          },
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.92,
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
                          if (_iscitizen != null) {
                            String citizenid = _iscitizen.toString();

                            segregatedcontroller.getuserqrdetails(citizenid);
                          } else {
                            Get.snackbar("Segregation", "Please Select Citizen",
                                backgroundColor: Colors.green.shade900,
                                colorText: Colors.white,
                                borderColor: Colors.white,
                                borderWidth: 1);
                          }
                        },
                        child: const Text("Get QR"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    segregatedcontroller.getuserqrdata == null
                        ? SizedBox()
                        : RepaintBoundary(
                            key: qrglobalKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DottedBorder(
                                color: Colors.green,
                                radius: Radius.circular(10),
                                dashPattern: [8, 4],
                                strokeWidth: 2,
                                child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Segregated Waste QR",
                                            style: GoogleFonts.roboto(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            segregatedcontroller
                                                .getallcitizenlist!.data!
                                                .where((element) =>
                                                    element.id.toString() ==
                                                    segregatedcontroller
                                                        .getuserqrdata!
                                                        .data!
                                                        .userDetailId
                                                        .toString())
                                                .first
                                                .name
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          QrImage(
                                            data: segregatedcontroller
                                                .getuserqrdata!.data!.sqr
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    segregatedcontroller.getuserqrdata == null
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              _shareQRCodeImage();
                            },
                            child: Container(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Share QR Code",
                                    style: GoogleFonts.roboto(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              ),
      );
    });
  }
}

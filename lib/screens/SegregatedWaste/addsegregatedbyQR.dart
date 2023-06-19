import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:zwc/controllers/DatabaseHelper.dart';
import 'package:zwc/controllers/segragated_wastecontroller.dart';
import 'package:zwc/screens/SegregatedWaste/QrScreensOverlays.dart';

class AddSegregateByQR extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<AddSegregateByQR> {
  final MobileScannerController mobilescannercontroller =
      MobileScannerController();
  final SegragatedController segregatedcontroller =
      Get.put(SegragatedController());
  final db = DatabaseHelper.instance;

  @override
  void dispose() {
    mobilescannercontroller.dispose();
    mobilescannercontroller.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    askpermission();
  }

  askpermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SegragatedController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Segregation'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place QR code in the area',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'scanning will be start automatically',
                    style: TextStyle(fontSize: 18.0, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                      controller: mobilescannercontroller,
                      onDetect: ((barcodes) async {
                        String scannedbarcodevalue =
                            barcodes.barcodes.first.rawValue.toString();

                        String selectdate =
                            DateFormat("yyyy-MM-dd").format(DateTime.now());
                        await mobilescannercontroller.stop();
                        log(scannedbarcodevalue.toString());

                        await db
                            .insertqrcode(
                                lqrcode: scannedbarcodevalue.toString(),
                                lqrdate: selectdate.toString())
                            .then((value) => {
                                  log(value.toString()),
                                  if (value > 1)
                                    {
                                      QuickAlert.show(
                                          barrierDismissible: false,
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'Data Added Successfully',
                                          text: 'You Can Sync Data Later',
                                          onConfirmBtnTap: () {
                                            Navigator.pop(context);
                                            mobilescannercontroller.start();
                                          }),
                                    }
                                  else
                                    {
                                      QuickAlert.show(
                                          barrierDismissible: false,
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Sorry',
                                          text: 'Data Not Added',
                                          confirmBtnText: "Try Again",
                                          onConfirmBtnTap: () {
                                            Navigator.pop(context);
                                            mobilescannercontroller.start();
                                          })
                                    }
                                });
                      })),
                  QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Data will be saved locally',
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

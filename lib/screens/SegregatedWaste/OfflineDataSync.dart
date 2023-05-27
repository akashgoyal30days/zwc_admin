import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:zwc/controllers/DatabaseHelper.dart';
import 'package:zwc/controllers/segragated_wastecontroller.dart';

class OfflineDataSync extends StatefulWidget {
  OfflineDataSync({Key? key}) : super(key: key);

  @override
  State<OfflineDataSync> createState() => _OfflineDataSyncState();
}

class _OfflineDataSyncState extends State<OfflineDataSync> {
  final db = DatabaseHelper.instance;
  List<localqrdatamodel> localqrdata = [];
  bool isloading = true;
  final SegragatedController segregatedcontroller =
      Get.put(SegragatedController());
  @override
  void initState() {
    getalllocalqrdatadetails();
    super.initState();
  }

  getalllocalqrdatadetails() async {
    isloading = true;
    var response = await db.getalllocalqrdata();
    localqrdata = response.map((e) => localqrdatamodel.fromJson(e)).toList();
    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You have ${localqrdata.length} Entries available",
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please click on Data sync to upload data",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            if (localqrdata.length > 0) {
                              segregatedcontroller
                                  .addsegregationdetailsbyQR(
                                      localqrdata: localqrdata)
                                  .then((value) => {
                                        if (value)
                                          {
                                            QuickAlert.show(
                                                barrierDismissible: false,
                                                context: context,
                                                type: QuickAlertType.success,
                                                title: 'Congratulations',
                                                text: 'Data Sync Successfully',
                                                onConfirmBtnTap: () async {
                                                  Navigator.pop(context);
                                                  await db
                                                      .deleteAlllocalQrdata()
                                                      .then((value) => {
                                                            getalllocalqrdatadetails()
                                                          });
                                                }),
                                          }
                                        else
                                          {
                                            QuickAlert.show(
                                                barrierDismissible: false,
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: 'Data Not Sync',
                                                text: 'Please Try Again ',
                                                onConfirmBtnTap: () async {
                                                  Navigator.pop(context);
                                                }),
                                          }
                                      });
                            } else {
                              Get.snackbar(
                                  "Qr Codes Data", "No Data Available To Sync",
                                  backgroundColor: Colors.blue,
                                  colorText: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 1);
                            }
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.80,
                            color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Data Sync",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class localqrdatamodel {
  String? qrcode;
  String? date;

  localqrdatamodel({this.qrcode, this.date});

  localqrdatamodel.fromJson(Map<String, dynamic> json) {
    qrcode = json['qrcode'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrcode'] = this.qrcode;
    data['date'] = this.date;
    return data;
  }
}

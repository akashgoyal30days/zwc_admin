import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zwc/widgets/descriptionfield.dart';
import 'package:zwc/widgets/inputfield.dart';

class messagebroadcastscreen extends StatefulWidget {
  const messagebroadcastscreen({Key? key}) : super(key: key);

  @override
  State<messagebroadcastscreen> createState() => _messagebroadcastscreenState();
}

class _messagebroadcastscreenState extends State<messagebroadcastscreen> {
  TextEditingController fcmtitlecontroller = TextEditingController();
  TextEditingController fcmbodycontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  showLoaderDialogwithName(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.green,
          ),
          Container(
            margin: const EdgeInsets.only(left: 25),
            child: Text(
              message,
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  sendnotification() async {
    Map body = {
      "to": "/topics/all",
      "notification": {
        "body": fcmbodycontroller.text.toString(),
        "title": fcmtitlecontroller.text.toString(),
      }
    };
    var apibody = json.encode(body);
    // log("Data we sending : " + apibody.toString());

    var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    try {
      var response = await http.post(url, body: apibody, headers: {
        "Authorization":
            "Key=AAAAAeyP5wc:APA91bFeUW0LF9jbuoeDVuJOdDODZ7KLaDipodlLbWWgApG84mJYFyAqexRS77EbL_BAUru0s4B1Q1bebZwFddc-qGNZ5SEjrVeiAcfEEpxDK5fpBr_fxN4EQHRbs1pfj6etpfSE2duw",
        "Content-Type": "application/json"
      });
      // log("Status Code : " + response.statusCode.toString());
      var jsonresponse = jsonDecode(response.body.toString());
      // log("Firebase Message Response : " + jsonresponse.toString());
      if (response.statusCode.toString() == "200") {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            content: Text("Notification Sent Successfully")));
        fcmtitlecontroller.clear();
        fcmbodycontroller.clear();
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            content: Text("Error please try again..")));
      }
    } catch (error) {
      // log("Firebase Message Error : " + error.toString());
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          content: Text("Error please try again..")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Message Broadcast"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            inputfield(
                keyboardtype: TextInputType.emailAddress,
                inputController: fcmtitlecontroller,
                hinttext: "Enter notification title",
                labeltext: "Notification Title *"),
            const SizedBox(
              height: 15,
            ),
            descriptionfield(
                inputController: fcmbodycontroller,
                hinttext: "Enter message",
                labeltext: "Message *"),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.green,
                textColor: Colors.white,
                child: const Text("Send Notification"),
                onPressed: () {
                  if (fcmtitlecontroller.text.isEmpty &&
                      fcmbodycontroller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.black,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Please fill alll required fields")));
                  } else {
                    showLoaderDialogwithName(context, "Please wait");
                    sendnotification();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

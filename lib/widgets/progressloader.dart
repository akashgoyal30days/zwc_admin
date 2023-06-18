import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Progressloaders {
  static void progressloaderdailog(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Loading...',
                        style: GoogleFonts.roboto(color: Colors.green))
                  ],
                )),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zwc/screens/dashboard/dashboard.dart';

class NoBranchselectedscreen extends StatefulWidget {
  NoBranchselectedscreen({Key? key}) : super(key: key);

  @override
  State<NoBranchselectedscreen> createState() => _NoBranchselectedscreenState();
}

class _NoBranchselectedscreenState extends State<NoBranchselectedscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Oops!!",
                style: GoogleFonts.montserrat(
                    fontSize: 25,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Branch Not Selected",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please Select a Branch to view Contents",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.deleteAll();
                    Get.off(DashboardScreen());
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.80,
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Back to Dashboard",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

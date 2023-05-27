import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwc/controllers/DatabaseHelper.dart';
import 'package:zwc/controllers/collection_management_controller.dart';
import 'package:zwc/controllers/dashboard_controller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/CollectionManagement/Collection.dart';
import 'package:zwc/screens/ErrorScreens/Nobranchselectedscreen.dart';
import 'package:zwc/screens/Purchase/PurchaseScreen.dart';
import 'package:zwc/screens/Sales/SalesScreen.dart';
import 'package:zwc/screens/SegregatedWaste/OfflineDataSync.dart';
import 'package:zwc/screens/SegregatedWaste/segregated_waste_screen.dart';
import 'package:zwc/screens/StockTransfer/StockTransfer.dart';
import 'package:zwc/screens/UserManagement/mymodulesscreen.dart';
import 'package:zwc/screens/WasteProcessing/wasteprocessingscreen.dart';
import 'package:zwc/screens/auth/login.dart';
import 'package:zwc/screens/dashboard/dashboard.dart';

class Navigationdrawer extends StatefulWidget {
  Navigationdrawer({Key? key}) : super(key: key);

  @override
  State<Navigationdrawer> createState() => _NavigationdrawerState();
}

class _NavigationdrawerState extends State<Navigationdrawer> {
  final db = DatabaseHelper.instance;
  @override
  void initState() {
    getdashboardbranchid();
    getqrcodedatalength();

    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
  }

  int? localqrdatalength;
  getqrcodedatalength() async {
    localqrdatalength = await db.getqrdatalength();
    
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "",
                style: TextStyle(fontSize: 15),
              ),
              accountEmail: Text(
                "",
                style: TextStyle(fontSize: 15),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/women-holding-globe.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.green),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Dashboard",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.back();
                Get.delete<DashboardController>();

                Get.to(DashboardScreen());
              },
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Collection Management",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      "Collection",
                      style: GoogleFonts.montserrat(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<CollectionManagementController>();

                      Get.to(Collection_management());
                    }
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Waste Processing",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (dbbranchid.toString() == "null" ||
                    dbbranchid.toString() == "0") {
                  Get.to(NoBranchselectedscreen());
                } else {
                  Get.back();

                  Get.to(WasteProcessingScreen());
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Stock Transfer",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (dbbranchid.toString() == "null" ||
                    dbbranchid.toString() == "0") {
                  Get.to(NoBranchselectedscreen());
                } else {
                  Get.back();

                  Get.to(StockTransferScreen());
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Sales",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (dbbranchid.toString() == "null" ||
                    dbbranchid.toString() == "0") {
                  Get.to(NoBranchselectedscreen());
                } else {
                  Get.back();

                  Get.to(SalesScreen());
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Purchase",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (dbbranchid.toString() == "null" ||
                    dbbranchid.toString() == "0") {
                  Get.to(NoBranchselectedscreen());
                } else {
                  Get.back();

                  Get.to(PurchaseScreen());
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Segregated Waste",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (dbbranchid.toString() == "null" ||
                    dbbranchid.toString() == "0") {
                  Get.to(NoBranchselectedscreen());
                } else {
                  Get.back();

                  Get.to(SegregatedWasteScreen());
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Offline Data Sync",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              trailing: localqrdatalength == null
                  ? SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          localqrdatalength.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
              onTap: () {
                Get.back();

                Get.to(OfflineDataSync());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "My Modules",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (dbbranchid.toString() == "null" ||
                    dbbranchid.toString() == "0") {
                  Get.to(NoBranchselectedscreen());
                } else {
                  Get.back();

                  Get.to(MyModeulesScreen());
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Logout",
                style: GoogleFonts.montserrat(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                SharedPreferences logoutuser =
                    await SharedPreferences.getInstance();
                await logoutuser.clear();
                Get.off(LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RectangleInputField extends StatelessWidget {
  final String? hintText;
  final String? errortext;
  final TextInputType? keyboardtype;

  final IconData? icon;
  final ValueChanged<String>? onchanged;
  final TextEditingController? textEditingController;
  final Color? cursorColor;
  final Color? iconColor;
  final Color? editTextBackgroundColor;
  final bool? hidedetails;
  final FormFieldValidator<String>? validator;

  RectangleInputField(
      {Key? key,
      this.hintText,
      this.keyboardtype,
      this.errortext,
      this.icon = Icons.person,
      this.onchanged,
      this.textEditingController,
      this.cursorColor,
      this.iconColor,
      this.hidedetails,
      this.editTextBackgroundColor,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.80,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              color: editTextBackgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              validator: validator,
              onChanged: onchanged,
              obscureText: hidedetails!,
              style: TextStyle(color: cursorColor),
              controller: textEditingController,
              cursorColor: cursorColor,
              decoration: InputDecoration(
                isDense: true,
                icon: Icon(
                  icon,
                  color: iconColor,
                ),
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
              keyboardType: keyboardtype,
            ),
          ),
        ],
      ),
    );
  }
}

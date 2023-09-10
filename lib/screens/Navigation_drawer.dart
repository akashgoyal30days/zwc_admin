import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwc/controllers/Branchcontroller.dart';
import 'package:zwc/controllers/DatabaseHelper.dart';
import 'package:zwc/controllers/Stock_transfer_controller.dart';
import 'package:zwc/controllers/areamastercontroller.dart';
import 'package:zwc/controllers/collection_management_controller.dart';
import 'package:zwc/controllers/dashboard_controller.dart';
import 'package:zwc/controllers/pickup_controller.dart';
import 'package:zwc/controllers/purchasecontroller.dart';
import 'package:zwc/controllers/resourcemanagemntcontroller.dart';
import 'package:zwc/controllers/salescpntroller.dart';
import 'package:zwc/controllers/segragated_wastecontroller.dart';
import 'package:zwc/controllers/stockreportcontroller.dart';
import 'package:zwc/controllers/usermanagemntconrollewer.dart';
import 'package:zwc/controllers/waste_processing_controller.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/screens/AreaMaster/Area/getareadetails.dart';
import 'package:zwc/screens/AreaMaster/City/getcitydetails.dart';
import 'package:zwc/screens/AreaMaster/District/getdistrictlist.dart';
import 'package:zwc/screens/AreaMaster/State/getstatedetails.dart';
import 'package:zwc/screens/BranchManagement/BankBranches/getallbankbranches.dart';
import 'package:zwc/screens/BranchManagement/Branchestypes/getallbranchestypes.dart';
import 'package:zwc/screens/CollectionManagement/Add_collection_details.dart';
import 'package:zwc/screens/CollectionManagement/Get_collection_details.dart';
import 'package:zwc/screens/ErrorScreens/Nobranchselectedscreen.dart';
import 'package:zwc/screens/IECProrams/GetIECprograms.dart';
import 'package:zwc/screens/Purchase/addpurchasedetails.dart';
import 'package:zwc/screens/Purchase/getpurchasedetailsscreen.dart';
import 'package:zwc/screens/ResouceManagement/WasteProcess/wasteprocesslistscreen.dart';
import 'package:zwc/screens/ResouceManagement/wasteCategory/wastecategoiry.dart';
import 'package:zwc/screens/ResouceManagement/wasteproduct/getallwasteproducts.dart';
import 'package:zwc/screens/Sales/addsalesdeatils.dart';
import 'package:zwc/screens/Sales/getsalesdetailsscreen.dart';
import 'package:zwc/screens/SegregatedWaste/OfflineDataSync.dart';
import 'package:zwc/screens/SegregatedWaste/addsegregatedbyQR.dart';
import 'package:zwc/screens/SegregatedWaste/addsegregatedwaste.dart';
import 'package:zwc/screens/SegregatedWaste/getsegregateddetails.dart';
import 'package:zwc/screens/StockReport/getstockreportbywastetype.dart';
import 'package:zwc/screens/StockReport/gettotalstockreport.dart';
import 'package:zwc/screens/StockTransfer/Add_stocktransfer_details.dart';
import 'package:zwc/screens/StockTransfer/getstocktransferdetails.dart';
import 'package:zwc/screens/UserManagement/getzwcaccounts.dart';
import 'package:zwc/screens/WasteProcessing/addwasteprocessing.dart';
import 'package:zwc/screens/WasteProcessing/getwasteprocessing.dart';
import 'package:zwc/screens/auth/login.dart';
import 'package:zwc/screens/dashboard/dashboard.dart';
import 'package:zwc/screens/messagebrodscast/messagebrodcast.dart';
import 'package:zwc/screens/pickup/pickup.dart';

class Navigationdrawer extends StatefulWidget {
  Navigationdrawer({Key? key}) : super(key: key);

  @override
  State<Navigationdrawer> createState() => _NavigationdrawerState();
}

class _NavigationdrawerState extends State<Navigationdrawer> {
  final db = DatabaseHelper.instance;
  final SegragatedController segregatedcontroller =
      Get.put(SegragatedController());
  final UserManagementController usermanagemntcontroller =
      Get.put(UserManagementController());
  @override
  void initState() {
    getdashboardbranchid();
    getqrcodedatalength();
    uploadallqrdataavailable();

    super.initState();
  }

  uploadallqrdataavailable() async {
    List<localqrdatamodel> localqrdata = [];
    var response = await db.getalllocalqrdata();
    localqrdata = response.map((e) => localqrdatamodel.fromJson(e)).toList();
    setState(() {});
    if (localqrdata.length > 0) {
      segregatedcontroller
          .addsegregationdetailsbyQR(localqrdata: localqrdata)
          .then((value) => {
                if (value)
                  {
                    // QuickAlert.show(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     type: QuickAlertType.success,
                    //     title: 'Congratulations',
                    //     text: 'Data Sync Successfully',
                    //     onConfirmBtnTap: () async {
                    //       Navigator.pop(context);
                    //       await db.deleteAlllocalQrdata();
                    //     }),
                  }
                else
                  {
                    // QuickAlert.show(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     type: QuickAlertType.error,
                    //     title: 'Data Not Sync',
                    //     text: 'Please Try Again ',
                    //     onConfirmBtnTap: () async {
                    //       Navigator.pop(context);
                    //     }),
                  }
              });
    } else {}
  }

  String? dbbranchid;
  String? username;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    username = await SharedPreferenceSingleTon.getData("username");
  }

  int? localqrdatalength;
  getqrcodedatalength() async {
    localqrdatalength = await db.getqrdatalength();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Hey! there ${username.toString()}",
                style: TextStyle(fontSize: 16),
              ),
              accountEmail: Text(
                "Welcome to Admin Panel",
                style: TextStyle(fontSize: 17),
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
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.back();
                Get.delete<DashboardController>();

                Get.to(DashboardScreen());
              },
            ),
             usermanagemntcontroller.PickuprequestModule.isNotEmpty&&
            usermanagemntcontroller.PickuprequestModule.first.isView
                        .toString() ==
                    "1"
                ? ListTile(
                    leading: Icon(
                      Icons.local_shipping,
                      color: Colors.green,
                      size: 25,
                    ),
                    title: Text(
                      "Pickup Requests",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      if (dbbranchid.toString() == "null" ||
                          dbbranchid.toString() == "0") {
                        Get.to(NoBranchselectedscreen());
                      } else {
                        Get.back();
                        Get.delete<PickupController>();

                        Get.to(PickUpRequest());
                      }
                    },
                  )
                : SizedBox(),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Area Master",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                             usermanagemntcontroller.StateModule.isNotEmpty&&

                usermanagemntcontroller.StateModule.first.isView.toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "State",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<AreaMasterController>();

                            Get.to(GetStateDetails());
                          }
                        },
                      )
                    : SizedBox(),
                                 usermanagemntcontroller.DistrictModule.isNotEmpty&&

                usermanagemntcontroller.DistrictModule.first.isView
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "District",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<AreaMasterController>();

                            Get.to(GetDistrictDetails());
                          }
                        },
                      )
                    : SizedBox(),
                                 usermanagemntcontroller.CityModule.isNotEmpty&&

                usermanagemntcontroller.CityModule.first.isView.toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "City",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<AreaMasterController>();

                            Get.to(GetCityDetails());
                          }
                        },
                      )
                    : SizedBox(),
                                 usermanagemntcontroller.AreaModule.isNotEmpty&&

                usermanagemntcontroller.AreaModule.first.isView.toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Area",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<AreaMasterController>();

                            Get.to(GetAreaDetails());
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "User Management",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      "ZWC Accounts",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<UserManagementController>();

                      Get.to(GetZwcAccountsScreen());
                    }
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Resource Management",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      "Waste Category",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<ResourceManagementController>();

                      Get.to(Getwastecategorydata());
                    }
                  },
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      "Waste Product",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<ResourceManagementController>();

                      Get.to(GetAllProducts());
                    }
                  },
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      "Waste Process",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<ResourceManagementController>();

                      Get.to(GetWasteProcessDetails());
                    }
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Branch Management",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      "Bank Branches",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<Branchcontroller>();

                      Get.to(Getallbankbranches());
                    }
                  },
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      "Branch Type",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<Branchcontroller>();

                      Get.to(GetBranchestypesDetails());
                    }
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Collection Management",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                             usermanagemntcontroller.CollectionsModule.isNotEmpty&&

                usermanagemntcontroller.CollectionsModule.first.isView
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Collection Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.delete<CollectionManagementController>();
                            Get.to(GetCollectionDetailsScreen());
                          }
                        },
                      )
                    : SizedBox(),
                                 usermanagemntcontroller.CollectionsModule.isNotEmpty&&

                usermanagemntcontroller.CollectionsModule.first.isAdd
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Add Collection Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.delete<CollectionManagementController>();
                            Get.to(addcollectiondetails());
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Waste Processing",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                             usermanagemntcontroller.WasteProcessingModule.isNotEmpty&&

                usermanagemntcontroller.WasteProcessingModule.first.isView
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Waste Processsing Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.delete<WasteProcessingController>();
                            Get.to(GetWasteProcessingScreen());
                          }
                        },
                      )
                    : SizedBox(),
                                 usermanagemntcontroller.WasteProcessingModule.isNotEmpty&&

                usermanagemntcontroller.WasteProcessingModule.first.isAdd
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Add Waste Processing",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.delete<WasteProcessingController>();
                            Get.to(addwasteprocessing());
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Stock Transfer",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                usermanagemntcontroller.Stocktransfermodule.isNotEmpty &&
                        usermanagemntcontroller.Stocktransfermodule.first.isView
                                .toString() ==
                            "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Stock Transfer Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<StockTransferController>();

                            Get.to(GetStockTransferDetails());
                          }
                        },
                      )
                    : SizedBox(),
                usermanagemntcontroller.Stocktransfermodule.isNotEmpty &&
                        usermanagemntcontroller.Stocktransfermodule.first.isAdd
                                .toString() ==
                            "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Add Stock Transfer",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<StockTransferController>();

                            Get.to(Addstockytransferdetails());
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Sales",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                             usermanagemntcontroller.SaleModule.isNotEmpty&&

                usermanagemntcontroller.SaleModule.first.isView.toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Sales Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<SalesController>();

                            Get.to(GetsalesdetailsScreen());
                          }
                        },
                      )
                    : SizedBox(),
                                 usermanagemntcontroller.SaleModule.isNotEmpty&&

                usermanagemntcontroller.SaleModule.first.isAdd.toString() == "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Add Sales",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<SalesController>();

                            Get.to(Addsalesdetails());
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Purchase",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [

                             usermanagemntcontroller.PurchaseModule.isNotEmpty&&

                usermanagemntcontroller.PurchaseModule.first.isView
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Purchase Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<PurchaseController>();

                            Get.to(GetpurchasedetailsScreen());
                          }
                        },
                      )
                    : SizedBox(),

                                 usermanagemntcontroller.PurchaseModule.isNotEmpty&&

                usermanagemntcontroller.PurchaseModule.first.isAdd.toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Add Purchase",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<PurchaseController>();

                            Get.to(AddPurchaseDeatils());
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Segregated Waste",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              children: [
                             usermanagemntcontroller.Segregatedwastemodule.isNotEmpty&&

                usermanagemntcontroller.Segregatedwastemodule.first.isView
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Segregated Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<SegragatedController>();

                            Get.to(GetSegregatedDetails());
                          }
                        },
                      )
                    : SizedBox(),
                                 usermanagemntcontroller.Segregatedwastemodule.isNotEmpty&&

                usermanagemntcontroller.Segregatedwastemodule.first.isAdd
                            .toString() ==
                        "1"
                    ? ListTile(
                        title: Center(
                          child: Text(
                            "Add Segregation Details",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<SegragatedController>();

                            Get.to(addsegregationdetails());
                          }
                        },
                      )
                    : SizedBox(),
                ListTile(
                  title: Center(
                    child: Text(
                      "Add Details by QR",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (dbbranchid.toString() == "null" ||
                        dbbranchid.toString() == "0") {
                      Get.to(NoBranchselectedscreen());
                    } else {
                      Get.back();
                      Get.delete<SegragatedController>();

                      Get.to(AddSegregateByQR());
                    }
                  },
                ),
              ],
            ),
             usermanagemntcontroller.StockReportModule.isNotEmpty&&

            usermanagemntcontroller.StockReportModule.first.isView.toString() ==
                    "1"
                ? ExpansionTile(
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.green,
                      size: 25,
                    ),
                    title: Text(
                      "Stock Reports",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ListTile(
                        title: Center(
                          child: Text(
                            "Total Stock Report",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<StockReportController>();

                            Get.to(gettotalstockreport());
                          }
                        },
                      ),
                      // ListTile(
                      //   title: Center(
                      //     child: Text(
                      //       "Stock Report by Category",
                      //       style: GoogleFonts.roboto(
                      //           color: Colors.green, fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     if (dbbranchid.toString() == "null" ||
                      //         dbbranchid.toString() == "0") {
                      //       Get.to(NoBranchselectedscreen());
                      //     } else {
                      //       Get.back();
                      //       Get.delete<StockReportController>();

                      //       Get.to(GetstockreportbyCategoryScreen());
                      //     }
                      //   },
                      // ),
                      ListTile(
                        title: Center(
                          child: Text(
                            "Stock Report by Waste",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (dbbranchid.toString() == "null" ||
                              dbbranchid.toString() == "0") {
                            Get.to(NoBranchselectedscreen());
                          } else {
                            Get.back();
                            Get.delete<StockReportController>();

                            Get.to(GetstockreportbywasteScreen());
                          }
                        },
                      ),
                    ],
                  )
                : SizedBox(),
             usermanagemntcontroller.IECProgramsModule.isNotEmpty&&

            usermanagemntcontroller.IECProgramsModule.first.isView.toString() ==
                    "1"
                ? ListTile(
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.green,
                      size: 25,
                    ),
                    title: Text(
                      "IEC Programs",
                      style: GoogleFonts.roboto(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      if (dbbranchid.toString() == "null" ||
                          dbbranchid.toString() == "0") {
                        Get.to(NoBranchselectedscreen());
                      } else {
                        Get.back();

                        Get.to(GetIECProgramsDetails());
                      }
                    },
                  )
                : SizedBox(),
            // ListTile(
            //   leading: Icon(
            //     Icons.dashboard,
            //     color: Colors.green,
            //     size: 25,
            //   ),
            //   title: Text(
            //     "Offline Data Sync",
            //     style: GoogleFonts.roboto(
            //         color: Colors.green, fontWeight: FontWeight.bold),
            //   ),
            //   trailing: localqrdatalength == null
            //       ? SizedBox()
            //       : Container(
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle, color: Colors.red),
            //           child: Padding(
            //             padding: const EdgeInsets.all(4.0),
            //             child: Text(
            //               localqrdatalength.toString(),
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //         ),
            //   onTap: () {
            //     // Get.back();

            //     // Get.to(OfflineDataSync());
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Notification Brodcast",
                style: GoogleFonts.roboto(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                Get.back();

                Get.to(messagebroadcastscreen());
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
                style: GoogleFonts.roboto(
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

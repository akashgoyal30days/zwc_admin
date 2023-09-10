import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:zwc/model/Getallcitizenlistmodel.dart';
import 'package:zwc/model/certificate_model.dart';
import 'package:zwc/model/getmymodulesmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';
import '../data/shared_preference.dart';

class UserManagementController extends GetxController {
  bool showloading = false;
  GetMyModulesModel? getmymodulesdata;
  List<ModuleData> PickuprequestModule = [];
  List<ModuleData> IECProgramsModule = [];
  List<ModuleData> WasteProcessingModule = [];
  List<ModuleData> PurchaseModule = [];
  List<ModuleData> SaleModule = [];
  List<ModuleData> StockReportModule = [];
  List<ModuleData> Segregatedwastemodule = [];
  List<ModuleData> Stocktransfermodule = [];
  List<ModuleData> CollectionsModule = [];
  List<ModuleData> StateModule = [];
  List<ModuleData> CityModule = [];
  List<ModuleData> DistrictModule = [];
  List<ModuleData> AreaModule = [];

  Future<GetMyModulesModel?> getmymodulesdetsils() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    String? roleid = await SharedPreferenceSingleTon.getData("userroleid");

    var response =
        await APIClient.post(URLS.getmymodules, body: {"role_id": roleid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getmymodulesdata = GetMyModulesModel.fromJson(body);
      log("Module : " + getmymodulesdata!.toJson().toString());
      PickuprequestModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Pickup Requests")
          .toList();
      IECProgramsModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "IEC Programs")
          .toList();
      WasteProcessingModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Waste Processing")
          .toList();
      PurchaseModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Purchase")
          .toList();
      SaleModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Sale")
          .toList();
      StockReportModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Stock Report")
          .toList();
      Segregatedwastemodule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Segregated Waste")
          .toList();
      CollectionsModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Collections")
          .toList();
      StateModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "State")
          .toList();
      CityModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "City")
          .toList();
      DistrictModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "District")
          .toList();
      AreaModule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Area")
          .toList();
      Stocktransfermodule = getmymodulesdata!.data!
          .where((element) => element.name.toString() == "Stock Transfer")
          .toList();

      showloading = false;
      update();
    }
    return getmymodulesdata;
  }

  GetAllCiitizenList? getallcitizenlist;

  Future<GetAllCiitizenList?> getallcitizen() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallcitizenlist,
        body: {"branch": branchid, "role": "citizens"});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallcitizenlist = GetAllCiitizenList.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getallcitizenlist;
  }

  CertificateModel? certificateModel;
  bool certificateLoading = true;
  getuserCertificate({String? uid}) async {
    certificateLoading = true;
    update();
    try {
      var response =
          await APIClient.post(URLS.getusercertificate, body: {"uid": uid});
      if (response.statusCode != 200) {
        throw "";
      }
      var body = json.decode(response.body);
      var imageResponse = await get(Uri.parse(body["data"]["image"]));
      if (imageResponse.statusCode != 200) throw "";
      certificateLoading = false;
      update();
      certificateModel = CertificateModel(
        ImageBytes: imageResponse.bodyBytes,
        imageURL: body["data"]["image"],
        pdfURL: body["data"]["pdf"],
      );
      return certificateModel;
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        titleText: Text(
          "Error retrieving Certificate",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        messageText: Text(
          "Please try again",
          style: TextStyle(color: Colors.white),
        ),
      ));
      certificateLoading = false;
      update();
    }
  }
}

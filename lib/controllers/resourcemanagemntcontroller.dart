import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/Getallproductlistmodel.dart';
import 'package:zwc/model/Geteallwasteprocess.dart';
import 'package:zwc/model/getallgstslabs.dart';
import 'package:zwc/model/getallwastecategorymodel.dart';
import 'package:zwc/model/getallwastetypemodel.dart';
import 'package:zwc/model/getproductunitlist.dart';
import 'package:zwc/model/getstatusmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';

class ResourceManagementController extends GetxController {
  bool showloading = false;

  GetAllWasteCategoryModel? getallwastecategoeydata;
  Future<GetAllWasteCategoryModel?> getallwastecategorylist() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallwastecategory);
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallwastecategoeydata = GetAllWasteCategoryModel.fromJson(body);
      showloading = false;
      update();
    }
    return getallwastecategoeydata;
  }

  GetAllWasteProcesses? getallwasteprocess;

  Future<GetAllWasteProcesses?> getallwasteprocesses() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(
      URLS.getallwasteprocess,
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallwasteprocess = GetAllWasteProcesses.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getallwasteprocess;
  }

  GetStatusModel? addwasteprocessdetails;
  Future<GetStatusModel?> addwasteprocesssdetails(
      {String? machinename, String? processname}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.addwasteprocessdetails, body: {
      "process_name": processname,
      "machine_name": machinename,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      addwasteprocessdetails = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return addwasteprocessdetails;
  }

  GetStatusModel? editwasteprocessdetails;
  Future<GetStatusModel?> editwasteprocesssdetails(
      {String? machinename, String? processname, processid}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.editwasteprocessdetails, body: {
      "process_id": processid,
      "process_name": processname,
      "machine_name": machinename,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      addwasteprocessdetails = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return addwasteprocessdetails;
  }

  GetAllProductList? getallproductlist;

  Future<GetAllProductList?> getallproductlistt() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(
      URLS.getallproductlist,
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallproductlist = GetAllProductList.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getallproductlist;
  }

  Getproductwastetypemodel? getproductwastetypedata;

  Future<Getproductwastetypemodel?> getproductswastetype() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(
      URLS.getproductwastetype,
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getproductwastetypedata = Getproductwastetypemodel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getproductwastetypedata;
  }

  Getproductunitmodel? getproductunitlist;

  Future<Getproductunitmodel?> getproductunitlistt() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(
      URLS.getproductunitlist,
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getproductunitlist = Getproductunitmodel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getproductunitlist;
  }

  Getallgstslabs? getproductgstslabs;

  Future<Getallgstslabs?> getallgstslabs() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(
      URLS.getproductgstslabs,
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getproductgstslabs = Getallgstslabs.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getproductgstslabs;
  }

  GetStatusModel? addwasteproductresponse;
  Future<GetStatusModel?> addwasteproduct(
      {String? categoryid,
      String? productname,
      String? salesprice,
      String? purchaseprice,
      String? wastetypeid,
      String? uintid,
      String? gstid}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.addwasteproduct, body: {
      "category_id": categoryid,
      "product_name": productname,
      "unit_id": uintid,
      "sale_price": salesprice,
      "purchase_price": purchaseprice,
      "gst_slab_id": gstid,
      "waste_type_id": wastetypeid
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      addwasteproductresponse = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return addwasteproductresponse;
  }
}

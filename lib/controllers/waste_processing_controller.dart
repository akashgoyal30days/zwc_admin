import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/Getallproductlistmodel.dart';
import 'package:zwc/model/Geteallwasteprocess.dart';
import 'package:zwc/model/addconsumptiondetailsproductdetails.dart';
import 'package:zwc/model/getallprocessedwastelistmodel.dart';
import 'package:zwc/model/getwasteprocessviewdetailsmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';

class WasteProcessingController extends GetxController {
  bool showloading = false;
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

  GetAllProcessedWasteList? getallprocessedwastelist;

  Future<GetAllProcessedWasteList?> getallwasteprocessedlist(
      {String? fromdate, String? todate}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallprocesswastelist,
        body: {"branch": branchid, "fromdate": fromdate, "todate": todate});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallprocessedwastelist = GetAllProcessedWasteList.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getallprocessedwastelist;
  }

  Future<bool?> uploadwasteprocessingdata(
      List<AddConsumptionDetails> consumptiondata,
      List<AddGeneratedProductDetails> generatedproductdata, String wasteprocess) async {
    showloading = true;
    update();
    List consumptionproductyarray = [];
    List consumptionquantityarray = [];

//
    List generatedproductarray = [];

    List generatequantityarray = [];

    String branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id")
            .toString();
    String Selecteddate = consumptiondata.first.Date.toString();
    consumptiondata.forEach((element) {
      consumptionquantityarray.add(element.Quantity);
      consumptionproductyarray.add(element.Productid);
    });
    generatedproductdata.forEach((element) {
      generatequantityarray.add(element.Quantity);
      generatedproductarray.add(element.Productid);
    });

    var response = await APIClient.post(URLS.uploadwasteprocessingdata, body: {
      "branch": branchid.toString(),
      "tdate": Selecteddate.toString(),
      "waste_process" : wasteprocess.toString(),
      "cproducts": consumptionproductyarray,
      "cquantity": consumptionquantityarray,
      "gproducts": generatedproductarray,
      "gquantity": generatequantityarray,
    });
    log({
      "branch": branchid.toString(),
      "tdate": Selecteddate.toString(),
      "cproducts": consumptionproductyarray,
      "cquantity": consumptionquantityarray,
      "gproducts": generatedproductarray,
      "gquantity": generatequantityarray,
    }.toString());
    var body = json.decode(response.body);
    log(body.toString());

    if (response.statusCode == 200) {
      showloading = false;
      if (body["status"].toString() == "true") {
        update();
        return true;
      } else {
        update();
        return false;
      }
    }
    return null;
  }


  GetWasteProcessViewDetailsModel? getwasteprocessdatabyid;
  Future getwasteprocessdetailsbyid({
    String? docid,
  }) async {
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getwasteprocessingdetailsbyid,
        body: {"id": docid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getwasteprocessdatabyid =
          GetWasteProcessViewDetailsModel.fromJson(body);
      log(response.body.toString());
      update();
    }
    return getwasteprocessdatabyid;
  }
}

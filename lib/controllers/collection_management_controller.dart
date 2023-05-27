import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/Getallproductlistmodel.dart';
import 'package:zwc/model/addwastedetailsmoodel.dart';
import 'package:zwc/model/getallcollectionlistmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';
import '../model/Getallcitizenlistmodel.dart';

class CollectionManagementController extends GetxController {
  bool showloading = false;
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

  Future<bool?> uploadwastedata(List<AddWasteDetailsModel> wasteadddata) async {
    showloading = true;
    update();
    List quantityarray = [];
    List ratesarray = [];
    List productarray = [];
    String branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id")
            .toString();
    String userid = wasteadddata.first.Citizenid.toString();
    String Selecteddate = wasteadddata.first.Date.toString();
    String isdonation = wasteadddata.first.Isdonation.toString();
    wasteadddata.forEach((element) {
      quantityarray.add(element.Quantity);
      ratesarray.add(element.Rates);
      productarray.add(element.Productid);
    });

    var response = await APIClient.post(URLS.uploaduserwastedata, body: {
      "branch_id": branchid.toString(),
      "user_id": userid.toString(),
      "is_donation": isdonation.toString(),
      "tdate": Selecteddate.toString(),
      "products": productarray,
      "quantity": quantityarray,
      "rates": ratesarray
    });
    log({
      "branch_id": branchid.toString(),
      "user_id": userid.toString(),
      "is_donation": isdonation.toString(),
      "tdate": Selecteddate.toString(),
      "products": productarray,
      "quantity": quantityarray,
      "rates": ratesarray
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

  Getallcollectionllistmodel? getallcollectionslist;

  Future<Getallcollectionllistmodel?> getallcollectionlist(
      {String? fromdate, String? todate}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallcollectionlist,
        body: {"branch": branchid, "fromdate": fromdate, "todate": todate});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallcollectionslist = Getallcollectionllistmodel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getallcollectionslist;
  }

  Future getcollectiondetailsbyid({
    String? docid,
  }) async {
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getstocktransferdetailsbyid,
        body: {"id": docid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      // getstocktransfersdetailsbyid =
      //     Getstocktransferdetailsbyidmodel.fromJson(body);
      log(response.body.toString());
      update();
    }
    // return getstocktransfersdetailsbyid;
  }
}

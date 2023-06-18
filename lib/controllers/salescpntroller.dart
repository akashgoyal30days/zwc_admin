import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/Getallproductlistmodel.dart';
import 'package:zwc/model/Getdashboardbranchesmodel.dart';
import 'package:zwc/model/addstocktransferwastedatamodel.dart';
import 'package:zwc/model/getallsaleslistmodel.dart';
import 'package:zwc/model/getallstocktransferlistmoidel.dart';
import 'package:zwc/model/getssalesviewdetailsmodel.dart';
import 'package:zwc/model/getstocktransferdetailbyidmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';

class SalesController extends GetxController {
  bool showloading = false;
  GetDashboardAllBranches? getallbranchdata;
  GetAllProductList? getallproductlist;
  GetAllSaleslist? getallsaleslist;

  Future<GetDashboardAllBranches?> getallbranches() async {
    showloading = true;
    update();

    var response = await APIClient.post(URLS.getalldashboardbranches);
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallbranchdata = GetDashboardAllBranches.fromJson(body);
      showloading = false;
    }
    update();
    return getallbranchdata;
  }

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

  Future<bool?> uploadsaleswastedata(
      List<AddsaleswasteData> wasteadddata) async {
    showloading = true;
    update();
    List quantityarray = [];
    List ratesarray = [];
    List productarray = [];
    String frombranchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id")
            .toString();
    String Selecteddate = wasteadddata.first.Date.toString();
    String tobranchid = wasteadddata.first.tobrannchid.toString();
    wasteadddata.forEach((element) {
      quantityarray.add(element.Quantity);
      ratesarray.add(element.Rates);
      productarray.add(element.Productid);
    });

    var response = await APIClient.post(URLS.uploadsaleswastedata, body: {
      "from_branch": frombranchid.toString(),
      "to_branch": tobranchid.toString(),
      "tdate": Selecteddate.toString(),
      "products": productarray,
      "quantity": quantityarray,
      "rates": ratesarray
    });
    log({
      "from_branch": frombranchid.toString(),
      "to_branch": tobranchid.toString(),
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

  Future<GetAllSaleslist?> getsaleslist(
      {String? fromdate, String? todate}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallsaleslist,
        body: {"branch": branchid, "fromdate": fromdate, "todate": todate});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallsaleslist = GetAllSaleslist.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getallsaleslist;
  }

  GetSalesViewDetailsModel? getsalesdetailsdatabyid;
  Future<GetSalesViewDetailsModel?> getsalesdetailsbyid({
    String? docid,
  }) async {
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response =
        await APIClient.post(URLS.getsalesdetailsbyid, body: {"id": docid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getsalesdetailsdatabyid =
          GetSalesViewDetailsModel.fromJson(body);
      log(body.toString());
      update();
    }
    return getsalesdetailsdatabyid;
  }
}

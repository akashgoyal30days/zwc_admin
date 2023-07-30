import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/getallproductcategorylist.dart';
import 'package:zwc/model/getstockreportbycategorymodel.dart';
import 'package:zwc/model/getstockreportbywaste.dart';
import 'package:zwc/model/gettotalstockreportmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';

class StockReportController extends GetxController {
  bool showloading = false;

  Getallproductcategorylist? getallproductcategorylist;

  Future<Getallproductcategorylist?> getallproductcategorylistt() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(
      URLS.getallproductcategorylist,
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallproductcategorylist = Getallproductcategorylist.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getallproductcategorylist;
  }

  GettotalstockreportModel? gettotalstockdata;

  Future<GettotalstockreportModel?> gettotalstockreport(
      {String? fromdate, String? todate}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getotalstockreport,
        body: {"branch": branchid, "fromdate": fromdate, "todate": todate});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      gettotalstockdata = GettotalstockreportModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return gettotalstockdata;
  }

  GetstockreportbycategoryModel? getstockdatabycategory;

  Future<GetstockreportbycategoryModel?> getstockreportbycategory(
      {String? fromdate, String? todate, String? category}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getstockreportbycategory, body: {
      "branch": branchid,
      "category": category,
      "fromdate": fromdate,
      "todate": todate
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getstockdatabycategory = GetstockreportbycategoryModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getstockdatabycategory;
  }

  GetstockreportbywasteModel? getstockdatabywaste;

  Future<GetstockreportbywasteModel?> getstockdatabywastetype(
      {String? fromdate, String? todate, String? category}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getstockreportbywastetype, body: {
      "branch": branchid,
      "category": category,
      "fromdate": fromdate,
      "todate": todate
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getstockdatabywaste = GetstockreportbywasteModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getstockdatabywaste;
  }
}

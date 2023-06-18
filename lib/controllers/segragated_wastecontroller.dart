import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/Getallcitizenlistmodel.dart';
import 'package:zwc/model/getallsegregatedlistmodel.dart';
import 'package:zwc/model/getuserqrdetailsmodel.dart';
import 'package:zwc/screens/SegregatedWaste/OfflineDataSync.dart';

import '../api/api_client.dart';
import '../api/urls.dart';

class SegragatedController extends GetxController {
  bool showloading = false;
  Getallsegregatedlist? getallsegregatedlist;
  Future<Getallsegregatedlist?> getsegregatedlist(
      {String? fromdate, String? todate}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getsegregatedlist,
        body: {"branch": branchid, "fromdate": fromdate, "todate": todate});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallsegregatedlist = Getallsegregatedlist.fromJson(body);
      showloading = false;
      update();
    }
    return getallsegregatedlist;
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

  GetUserQrDetailsModel? getuserqrdata;

  Future<GetUserQrDetailsModel?> getuserqrdetails(String? citizenid) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getuserQrdetails, body: {
      "id": citizenid,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getuserqrdata = GetUserQrDetailsModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getuserqrdata;
  }

  Future<bool> addsegregationdetails(
      {String? citizenid,
      String? issegregated,
      String? transactiondate}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.adsegregationwaste, body: {
      "branch": branchid,
      "user": citizenid,
      "status": issegregated,
      "cdate": transactiondate
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      showloading = false;

      update();
    }
    if (body["status"].toString() == "true") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addsegregationdetailsbyQR(
      {List<localqrdatamodel>? localqrdata}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    List Qrarray = [];
    List datearray = [];
    localqrdata!.forEach((element) {
      Qrarray.add(element.qrcode.toString());
      datearray.add(element.date.toString());
    });
    log({"qr": Qrarray, "date": datearray}.toString());

    var response = await APIClient.post(URLS.addsegregatedatabyQR,
        body: {"qr": Qrarray, "date": datearray});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      showloading = false;
      log({"qr": Qrarray, "date": datearray}.toString());
      log(body.toString());

      update();
    }
    if (body["status"].toString() == "true") {
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/getallbankbranchmodel.dart';
import 'package:zwc/model/getallbranchestypemodel.dart';
import 'package:zwc/model/getalldistrictmodel.dart';
import 'package:zwc/model/getalllareamodel.dart';
import 'package:zwc/model/getallstateslistmodel.dart';
import 'package:zwc/model/getcitymodel.dart';
import 'package:zwc/model/getstatusmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';

class Branchcontroller extends GetxController {
  bool showloading = false;

  Getallstatesmodel? getallstateslist;
  Future<Getallstatesmodel?> getallstatesslist() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallastates);
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallstateslist = Getallstatesmodel.fromJson(body);
      showloading = false;
      update();
    }
    return getallstateslist;
  }

  Getallbankbranchmodel? getallbankbrancheslist;
  Future<Getallbankbranchmodel?> getallbankbranches() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallbankbranches);
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallbankbrancheslist = Getallbankbranchmodel.fromJson(body);
      showloading = false;
      update();
    }
    return getallbankbrancheslist;
  }

  Getallbranchestypemodel? getallbranchestypelist;
  Future<Getallbranchestypemodel?> getallbranchestypes() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallbranchestypes);
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallbranchestypelist = Getallbranchestypemodel.fromJson(body);
      showloading = false;
      update();
    }
    return getallbranchestypelist;
  }

  GetStatusModel? addbranchtyperesponse;
  Future<GetStatusModel?> addbranchtype({
    String? branchname,
    String? ad1,
    String? ad2,
    String? ad3,
    String? ad4,
    String? ad5,
    String? ad6,
    String? ad7,
    String? ad8,
    String? ad9,
    String? ad10,
  }) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.addbranchtype, body: {
      "branch_type": branchname,
      "ad1": ad1,
      "ad2": ad2,
      "ad3": ad3,
      "ad4": ad4,
      "ad5": ad5,
      "ad6": ad6,
      "ad7": ad7,
      "ad8": ad8,
      "ad9": ad9,
      "ad10": ad10
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      addbranchtyperesponse = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return addbranchtyperesponse;
  }

  GetStatusModel? addbankbranchresponse;
  Future<GetStatusModel?> addbankbranch({
    String? branchtypeid,
    String? branchname,
    String? branchcontact,
    String? branchemail,
    String? branchaddresss,
    String? areaid,
    String? issale,
    String? ispurchase,
    String? iscollectionreq,
    String? isstocktransfer,
    String? iswasteprocessing,
    String? isdepoist,
  }) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.addbankbranch, body: {
      "branch_type_id": branchtypeid,
      "branch_name": branchname,
      "branch_contact": branchcontact,
      "branch_email": branchemail,
      "branch_address": branchaddresss,
      "area_id": areaid,
      "is_collection_request": iscollectionreq,
      "is_direct_submission": isdepoist,
      "is_sale": issale,
      "is_stock_transfer": isstocktransfer,
      "is_waste_processing": iswasteprocessing,
      "is_purchase": ispurchase
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      addbankbranchresponse = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return addbankbranchresponse;
  }

  Getalldistrictmodel? getdistrictdata;
  Future<Getalldistrictmodel?> getdistrictdetailsbystate(
      {String? stateid}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getalldistrictbystate,
        body: {"state_id": stateid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getdistrictdata = Getalldistrictmodel.fromJson(body);
      showloading = false;
      update();
    }
    return getdistrictdata;
  }

  GetCityModel? getcitydata;
  Future<GetCityModel?> getcitydatabydistrict({String? districtid}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getcitybydistriuct,
        body: {"district_id": districtid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getcitydata = GetCityModel.fromJson(body);
      showloading = false;
      update();
    }
    return getcitydata;
  }

  GetAreasModel? getareadata;
  Future<GetAreasModel?> getareadtabycityid({String? cityid}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getallareasbycityid,
        body: {"city_id": cityid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getareadata = GetAreasModel.fromJson(body);
      showloading = false;
      update();
    }
    return getareadata;
  }

  GetStatusModel? geteditdistrictstatus;
  Future<GetStatusModel?> editdistrictdetails(
      {String? stateid, String? districtid, String? districtname}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.editdistrictdetails, body: {
      "name": districtname,
      "state_id": stateid,
      "district_id": districtid,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      geteditdistrictstatus = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return geteditdistrictstatus;
  }

  GetStatusModel? geteditareastatus;
  Future<GetStatusModel?> editareadetails(
      {String? cityid, String? areaid, String? areaname}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.editareadetails, body: {
      "name": areaname,
      "city_id": cityid,
      "area_id": areaid,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      geteditareastatus = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return geteditareastatus;
  }

  GetStatusModel? geteditcitydetails;
  Future<GetStatusModel?> editcitydetails(
      {String? cityid,
      String? districtid,
      String? cityname,
      String? pincode}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.editcitydetails, body: {
      "name": cityname,
      "city_id": cityid,
      "district_id": districtid,
      "pincode": pincode
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      geteditcitydetails = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return geteditcitydetails;
  }

  GetStatusModel? getaddsistrictstatus;
  Future<GetStatusModel?> adddistrictdetails(
      {String? stateid, String? districtname}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.adddistrictdetails, body: {
      "name": districtname,
      "state_id": stateid,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getaddsistrictstatus = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getaddsistrictstatus;
  }

  GetStatusModel? getaddareastatus;
  Future<GetStatusModel?> addareadetails(
      {String? cityid, String? areaname}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.addareadetails, body: {
      "name": areaname,
      "city_id": cityid,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getaddareastatus = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getaddareastatus;
  }

  GetStatusModel? getaddcitydetails;
  Future<GetStatusModel?> addcitydetails(
      {String? districtid, String? cityname, String? pinocde}) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.addcitydetails, body: {
      "name": cityname,
      "district_id": districtid,
      "pincode": pinocde
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getaddcitydetails = GetStatusModel.fromJson(body);
      showloading = false;
      log(body.toString());
      update();
    }
    return getaddcitydetails;
  }
}

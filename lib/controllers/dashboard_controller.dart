import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:zwc/api/api_client.dart';
import 'package:zwc/api/urls.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/Getdashboardbranchesmodel.dart';
import 'package:zwc/model/Getstpmodel.dart';

import '../model/certificate_model.dart';
import '../model/getstockreportbycategorymodel.dart';

class DashboardController extends GetxController {
  bool showLoading = false, certificateLoading = false;
  String? errorText;
  String? Waste_collected;
  String? drywet_Waste_collected;
  String? DrywasteCollected;
  String? wet_Waste_collected;
  String? totalcitizen;
  String? totalcollector;
  String? totalaggregator;
  String? totalwarriors;
  String? totalrecyclers;
  double? WaterLastFlow;
  double? TotalWaterRecylled;
  bool? showcollectiondata;
  bool? showsegregateddata;
  bool? showSTP;

  String rewards = "0";
  CertificateModel? certificateModel;
  List<WasteCollectedModel> wasteCollected = [];
  List<CollectionModel> collection = [];
  List<drywetWasteCollectedModel> drywetwastecollection = [];
  List<WasteCollectedModel> wetwastecollection = [];
  List segregateddata = [];
  List Stpdata = [];
  List<WaterStpDataModel> WatermeterData = [];

  final List<CollectionModel> environmentSaved = [];
  MembersData? membersData;
  GetDashboardAllBranches? getallbranchdata;

  DateTime? lastUpdatedOn;
  DashboardController();

  Future<GetDashboardAllBranches?> getallbranches() async {
    showLoading = true;
    update();

    var response = await APIClient.post(URLS.getalldashboardbranches);
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getallbranchdata = GetDashboardAllBranches.fromJson(body);
      getallbranchdata!.data!.add(Data(
        id: "0",
        branchName: "All Branches",
        city: "",
        area: "",
      ));
      showLoading = false;

      return getallbranchdata;
    }
    update();
    return getallbranchdata;
  }

  Future getDashboard(
      DateTimeRange dateRange, String branchid, String gap) async {
    certificateModel = null;
    showLoading = true;
    errorText = null;
    wasteCollected.clear();
    collection.clear();
    environmentSaved.clear();
    wetwastecollection.clear();
    drywetwastecollection.clear();
    update();

    var response = await APIClient.post(URLS.getDashboard, body: {
      "branch": "${branchid}",
      "fromdate": DateFormat("y-MM-dd").format(dateRange.start).toString(),
      "todate": DateFormat("y-MM-dd").format(dateRange.end).toString(),
      "gap": gap.toString()
    });

    if (response.statusCode != 200) {
      showLoading = false;
      update();
      return;
    }

    var body = json.decode(response.body);
    log(body.toString());
    List labels, data, data1;
    try {
      totalcitizen = body["data"]["citizens"].toString();
      totalaggregator = body["data"]["aggregators"].toString();
      totalcollector = body["data"]["collectors"].toString();
      totalrecyclers = body["data"]["recyclers"].toString();
      totalwarriors = body["data"]["warriors"].toString();
      showcollectiondata = body["widgets"]["collection"].toString() == "1";
      showsegregateddata = body["widgets"]["segregated"].toString() == "1";
      showSTP = body["widgets"]["stp"].toString() == "1";
      membersData = MembersData(totalcitizen, totalaggregator, totalwarriors,
          totalrecyclers, totalcollector);
    } catch (e) {}
    try {
      segregateddata = body["data"]["segregate"] as List;
      Stpdata = body["data"]["stp"] as List;
      var wdata = Stpdata[0]["data"]["history"] as List;
      WaterLastFlow = Stpdata[0]["data"]["latest"]["params"]["volume"];
      TotalWaterRecylled = Stpdata[0]["data"]["sum"]["params"]["volume"];
      for (var i = 0; i < wdata.length; i++) {
        WatermeterData.add(WaterStpDataModel(
            wdata[i]["date"].toString(), wdata[i]["params"]["volume"]));
      }
      Waste_collected =
          body["data"]["waste_collection_graph"]["first"]["title"].toString();
      labels = body["data"]["waste_collection_graph"]["first"]["label"] as List;
      data = body["data"]["waste_collection_graph"]["first"]["value"] as List;
      for (int i = 0; i < labels.length; ++i) {
        wasteCollected.add(WasteCollectedModel(labels[i], data[i].toDouble()));
      }
    } catch (e) {}
    try {
      drywet_Waste_collected =
          body["data"]["dry_wet_waste_collection_graph"]["title"].toString();
      DrywasteCollected = body["data"]["dry_wet_waste_collection_graph"]
              ["total_dry"]
          .toString();
      labels = body["data"]["dry_wet_waste_collection_graph"]["label"] as List;
      data = body["data"]["dry_wet_waste_collection_graph"]["wet"] as List;
      data1 = body["data"]["dry_wet_waste_collection_graph"]["dry"] as List;
      for (int i = 0; i < labels.length; ++i) {
        drywetwastecollection.add(drywetWasteCollectedModel(
            labels[i], data[i].toDouble(), data1[i].toDouble()));
      }
    } catch (e) {}

    try {
      labels = body["data"]["category_collection_graph"]["scaleLabels"] as List;
      data = body["data"]["category_collection_graph"]["data"] as List;

      for (int i = 0; i < labels.length; ++i) {
        collection.add(CollectionModel(labels[i], data[i].toDouble()));
      }
    } catch (e) {}

    try {
      labels = body["data"]["environment_saved_graph"]["scaleLabels"] as List;
      data = body["data"]["environment_saved_graph"]["data"] as List;

      for (int i = 0; i < labels.length; ++i) {
        environmentSaved.add(CollectionModel(labels[i], data[i].toDouble()));
      }
    } catch (e) {}

    showLoading = false;
    lastUpdatedOn = DateTime.now();
    update();
  }

  GetstockreportbycategoryModel? getstockdatabycategory;

  Future<GetstockreportbycategoryModel?> getstockreportbycategory(
      {String? fromdate, String? todate, String? category}) async {
    showLoading = true;
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
      showLoading = false;
      // log(body.toString());
      update();
    }
    return getstockdatabycategory;
  }

  getCertificate() async {
    if (certificateModel != null) return certificateModel;
    certificateLoading = true;
    update();
    try {
      var response = await APIClient.post(URLS.certificate);
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

class WasteCollectedModel {
  final String label;
  final double data;
  const WasteCollectedModel(this.label, this.data);
}

class drywetWasteCollectedModel {
  final String label;
  final double data;
  final double data2;
  const drywetWasteCollectedModel(this.label, this.data, this.data2);
}

class CollectionModel {
  final String label;
  final double data;
  const CollectionModel(this.label, this.data);
}

class WaterStpDataModel {
  final String label;
  final double data;
  const WaterStpDataModel(this.label, this.data);
}

class MembersData {
  final String? totalcitizens;
  final String? totalaggregator;
  final String? totalwarriors;
  final String? totalrecyclers;
  final String? totalcollectors;

  const MembersData(this.totalcitizens, this.totalaggregator,
      this.totalwarriors, this.totalrecyclers, this.totalcollectors);
}

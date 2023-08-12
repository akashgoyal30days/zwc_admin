import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';

import 'package:zwc/api/api_client.dart';
import 'package:zwc/api/urls.dart';

import '../data/shared_preference.dart';

class PickupController extends GetxController {
  bool loadingHistory = false;
  String errorText = "", newRequestErrorText = "";

  final List<PickRequestModel> pendingRequests = [],
      acceptedRequests = [],
      rejectedRequests = [],
      completedRequests = [];

  

  getHistoryRequests() async {
    pendingRequests.clear();
    acceptedRequests.clear();
    rejectedRequests.clear();
    completedRequests.clear();
    loadingHistory = true;
    errorText = "";
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.pastRequests,
        body: {"branch": branchid.toString()});
    var body = json.decode(response.body);
    log(body.toString());

    if (response.statusCode != 200) {
      errorText = "unkown Error";
      loadingHistory = false;
      update();
    }
    for (var pickuprequest in (body["data"] as List).reversed.toList()) {
      var model = PickRequestModel(pickuprequest);
      if (model.pickRequestsType == 0) {
        pendingRequests.add(model);
      } else if (model.pickRequestsType == 1) {
        completedRequests.add(model);
      } else if (model.pickRequestsType == 2) {
        rejectedRequests.add(model);
      } else if (model.pickRequestsType == 3) {
        acceptedRequests.add(model);
      }
    }
    loadingHistory = false;
    update();
  }
}

class PickRequestModel {
  final String id,
      bankBranchId,
      requestedBy,
      name,
      email,
      requestNo,
      requestImage,
      approxWeight,
      slotTime,
      collectorId,
      rejectionRemarks,
      requestStatus,
      lcb,
      lct;
  final int pickRequestsType;
  final String slotDateFrom,
      slotDateTo,
      acceptanceDateTime,
      requestDateTime,
      pickupDateTime,
      rejectionDateTime;
  PickRequestModel(data)
      : id = data["id"],
        requestDateTime = (data["request_date_time"]),
        name = (data["name"]??""),
        email = (data["email"]??""),
        slotDateFrom = (data["slot_date_from"]),
        slotDateTo = (data["slot_date_to"]),
        acceptanceDateTime = (data["acceptance_date_time"]),
        pickupDateTime = (data["pickup_date_time"]),
        rejectionDateTime = (data["rejection_date_time"]),
        pickRequestsType = int.parse(data["request_status"] ?? "0"),
        requestImage = data["request_image"]?.toString() ?? "",
        approxWeight = data["approx_weight"]?.toString() ?? "",
        bankBranchId = data["bank_branch_id"]?.toString() ?? "",
        requestedBy = data["requested_by"]?.toString() ?? "",
        requestNo = data["request_no"]?.toString() ?? "",
        slotTime = data["slot_time"]?.toString() ?? "",
        collectorId = data["collector_id"]?.toString() ?? "",
        rejectionRemarks = data["rejection_remarks"]?.toString() ?? "",
        requestStatus = data["request_status"]?.toString() ?? "",
        lcb = data["lcb"]?.toString() ?? "",
        lct = data["lct"]?.toString() ?? "";
}

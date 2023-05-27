import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/model/getmymodulesmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';
import '../data/shared_preference.dart';

class UserManagementController extends GetxController {
  bool showloading = false;
  GetMyModulesModel? getmymodulesdata;
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
      log(body.toString());
      showloading = false;
      update();
    }
    return getmymodulesdata;
  }
}

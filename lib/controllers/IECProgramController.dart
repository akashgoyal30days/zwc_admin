import 'dart:convert';

import 'package:get/get.dart';
import 'package:zwc/data/shared_preference.dart';
import 'package:zwc/model/addiecprogramresponsemodel.dart';
import 'package:zwc/model/addiecprogramtopicresponsemodel.dart';
import 'package:zwc/model/getalliecprogrammodel.dart';
import 'package:zwc/model/getiecprogramtopicsmodel.dart';

import '../api/api_client.dart';
import '../api/urls.dart';

class IECProgramController extends GetxController {
  bool showloading = false;

  GetAllIECProgramsModel? getalliecprogramlist;
  Future<GetAllIECProgramsModel?> getalliecprograms() async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getalliecprograms);
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getalliecprogramlist = GetAllIECProgramsModel.fromJson(body);
      showloading = false;
      update();
    }
    return getalliecprogramlist;
  }

  GetAllIECProgramTopicsModel? getiecprogramstopicsdata;
  Future<GetAllIECProgramTopicsModel?> gettopicsbyprogramid(
      String? docid) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response = await APIClient.post(URLS.getiecprogramtopics,
        body: {"program_id": docid});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      getiecprogramstopicsdata = GetAllIECProgramTopicsModel.fromJson(body);
      showloading = false;
      update();
    }
    return getiecprogramstopicsdata;
  }

  AddIECprogramResponseModel? addiecprogramresponse;
  Future<AddIECprogramResponseModel?> addiecprogram(String? programname) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");

    var response =
        await APIClient.post(URLS.addiecprogram, body: {"name": programname});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      addiecprogramresponse = AddIECprogramResponseModel.fromJson(body);
      showloading = false;
      update();
    }
    return addiecprogramresponse;
  }

  AddIECprogramTopicResponseModel? addiecprogramtopicresponse;
  Future<AddIECprogramTopicResponseModel?> addiecprogramtopics(
      String? programid, String? topicname) async {
    showloading = true;
    update();
    String? branchid =
        await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    List topicarray = [];
    topicarray.add(topicname);

    var response = await APIClient.post(URLS.addiecprogramtopicname,
        body: {"program_id": programid, "topics": topicarray});
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      addiecprogramtopicresponse =
          AddIECprogramTopicResponseModel.fromJson(body);
      showloading = false;
      update();
    }
    return addiecprogramtopicresponse;
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zwc/screens/dashboard/dashboard.dart';

import '../api/api_client.dart';
import '../api/urls.dart';
import '../data/shared_preference.dart';

class LoginController extends GetxController {
  bool showLoading = false, otpMode = false, gettingOTP = false;
  String? errorMessage;

  loginSuccess(Map body) async {
    await SharedPreferenceSingleTon.setData("token", body["token"]);
    await SharedPreferenceSingleTon.setData("uid", body["uid"]);
    await SharedPreferenceSingleTon.setData("userroleid", body["user_role_id"]);
    await SharedPreferenceSingleTon.setData(
        "dashboard_branch_id", body["branch_id"]);
    await SharedPreferenceSingleTon.setData("username", body["name"]);
    await SharedPreferenceSingleTon.setData("loginbranchid", body["branch_id"]);

    Get.off(() => const DashboardScreen());
  }

  passwordLogin(String phoneNumber, String password) async {
    if (phoneNumber.isEmpty || password.isEmpty) return;
    showLoading = true;
    errorMessage = null;
    otpMode = false;
    update();

    var response = await APIClient.post(URLS.userNameLogin, body: {
      "username": phoneNumber,
      "password": password,
    });

    var body = json.decode(response.body) ?? {};
    log(body.toString());
    if (response.statusCode != 200) {
      errorMessage = body?["message"] ?? "Unkown Error";
      showLoading = false;
      update();
      return;
    }

    if (body?["status"] == true) {
      loginSuccess(body);
      return;
    }

    showLoading = false;
    update();
  }

  getOTP(String phoneNumber) async {
    gettingOTP = true;
    errorMessage = null;
    update();

    var response = await APIClient.post(
      URLS.loginViaOTP,
      body: {"phone_num": phoneNumber},
    );

    var body = json.decode(response.body) ?? {};
    otpMode = response.statusCode == 200;

    if (response.statusCode != 200) {
      errorMessage = body?["message"] ?? "Unkown Error";
    }

    gettingOTP = false;
    update();
    return true;
  }

  verifyOTP(String phoneNumber, String otp) async {
    showLoading = true;
    errorMessage = null;
    update();

    var response = await APIClient.post(
      URLS.verifyLoginOTP,
      body: {
        "username": phoneNumber,
        "otp": otp,
      },
    );

    var body = json.decode(response.body) ?? {};
    log(body.toString());

    if (response.statusCode != 200) {
      errorMessage = body?["message"] ?? "Unkown Error";
      showLoading = false;
      update();
      return;
    }

    if (body?["status"] == true) {
      loginSuccess(body);
      return;
    }
  }
}

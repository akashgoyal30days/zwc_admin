import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwc/api/api_client.dart';
import 'package:zwc/api/urls.dart';

class RewardsController extends GetxController {
  bool balanceLoading = false, transactionLoading = false;
  String balance = "";
  List<TransactionModel> transactions = [];

  RewardsController(DateTimeRange timeRange) {
    getBalance();
    getTransactions(timeRange);
  }

  getBalance() async {
    balanceLoading = true;
    update();
    var response = await APIClient.post(URLS.currentBalance);

    if (response.statusCode != 200) {
      balanceLoading = false;
      return;
    }

    balance = json.decode(response.body)["balance"].toString();
    balanceLoading = false;
    update();
  }

  getTransactions(DateTimeRange dateTimeRange) async {
    transactionLoading = true;
    transactions.clear();
    update();
    var response = await APIClient.post(URLS.transactions, body: {
      "from":
          "${dateTimeRange.start.year}-${dateTimeRange.start.month}-${dateTimeRange.start.day}",
      "to":
          "${dateTimeRange.end.year}-${dateTimeRange.end.month}-${dateTimeRange.end.day}",
    });

    if (response.statusCode != 200) {
      transactionLoading = false;
      return;
    }

    var data = json.decode(response.body)["data"] as List;
    for (var transaction in data) {
      transactions.add(TransactionModel(transaction));
    }

    transactionLoading = false;
    update();
  }
}

class TransactionModel {
  final String id, bankBranchID, date, remark, lcb, lct, branchName;
  final double amount;
  TransactionModel(data)
      : id = data["id"].toString(),
        bankBranchID = data["bank_branch_id"].toString(),
        date = data["transaction_date"].toString(),
        amount = double.parse(data["transaction_amount"].toString()),
        remark = data["transaction_remark"].toString(),
        lcb = data["lcb"].toString(),
        lct = data["lct"].toString(),
        branchName = data["branch_name"].toString();
}

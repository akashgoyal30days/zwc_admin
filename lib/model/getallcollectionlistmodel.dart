class Getallcollectionllistmodel {
  bool? status;
  List<Data>? data;

  Getallcollectionllistmodel({this.status, this.data});

  Getallcollectionllistmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? transactionId;
  String? transactionDate;
  String? amount;
  String? isDonation;
  String? name;
  String? email;
  String? phoneNum;
  String? totalquantity;

  Data(
      {this.id,
      this.transactionId,
      this.transactionDate,
      this.amount,
      this.isDonation,
      this.name,
      this.totalquantity,
      this.email,
      this.phoneNum});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    transactionDate = json['transaction_date'];
    amount = json['amount'];
    isDonation = json['is_donation'];
    totalquantity = json['total'];
    name = json['name'];
    email = json['email'];
    phoneNum = json['phone_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['transaction_date'] = this.transactionDate;
    data['amount'] = this.amount;
    data['is_donation'] = this.isDonation;
    data['name'] = this.name;
    data['total'] = this.totalquantity;
    data['email'] = this.email;
    data['phone_num'] = this.phoneNum;
    return data;
  }
}

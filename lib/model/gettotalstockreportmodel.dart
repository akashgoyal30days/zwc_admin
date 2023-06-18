class GettotalstockreportModel {
  bool? status;
  List<Data>? data;

  GettotalstockreportModel({this.status, this.data});

  GettotalstockreportModel.fromJson(Map<String, dynamic> json) {
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
  String? category;
  dynamic id;
  dynamic out;
  dynamic inn;
  dynamic opening;
  dynamic balance;

  Data(
      {this.category, this.id, this.out, this.inn, this.opening, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    out = json['out'];
    inn = json['in'];
    opening = json['opening'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['id'] = this.id;
    data['out'] = this.out;
    data['in'] = this.inn;
    data['opening'] = this.opening;
    data['balance'] = this.balance;
    return data;
  }
}

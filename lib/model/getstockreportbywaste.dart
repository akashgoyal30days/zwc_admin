class GetstockreportbywasteModel {
  bool? status;
  List<Data>? data;

  GetstockreportbywasteModel({this.status, this.data});

  GetstockreportbywasteModel.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  dynamic outQuantity;
  dynamic inQuantity;
  dynamic balance;
  dynamic opening;

  Data(
      {this.id,
      this.productName,
      this.outQuantity,
      this.inQuantity,
      this.balance,
      this.opening});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    outQuantity = json['out_quantity'];
    inQuantity = json['in_quantity'];
    balance = json['balance'];
    opening = json['opening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['out_quantity'] = this.outQuantity;
    data['in_quantity'] = this.inQuantity;
    data['balance'] = this.balance;
    data['opening'] = this.opening;
    return data;
  }
}

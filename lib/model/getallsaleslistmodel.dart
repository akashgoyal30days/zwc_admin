class GetAllSaleslist {
  bool? status;
  List<Data>? data;

  GetAllSaleslist({this.status, this.data});

  GetAllSaleslist.fromJson(Map<String, dynamic> json) {
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
  String? fromBranch;
  String? toBranch;
  String? transactionId;
  String? tdate;
  String? transactionAmount;
  String? sgstAmount;
  String? cgstAmount;
  String? igstAmount;
  String? lcb;
  String? lct;

  Data(
      {this.id,
      this.fromBranch,
      this.toBranch,
      this.transactionId,
      this.tdate,
      this.transactionAmount,
      this.sgstAmount,
      this.cgstAmount,
      this.igstAmount,
      this.lcb,
      this.lct});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromBranch = json['from_branch'];
    toBranch = json['to_branch'];
    transactionId = json['transaction_id'];
    tdate = json['tdate'];
    transactionAmount = json['transaction_amount'];
    sgstAmount = json['sgst_amount'];
    cgstAmount = json['cgst_amount'];
    igstAmount = json['igst_amount'];
    lcb = json['lcb'];
    lct = json['lct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_branch'] = this.fromBranch;
    data['to_branch'] = this.toBranch;
    data['transaction_id'] = this.transactionId;
    data['tdate'] = this.tdate;
    data['transaction_amount'] = this.transactionAmount;
    data['sgst_amount'] = this.sgstAmount;
    data['cgst_amount'] = this.cgstAmount;
    data['igst_amount'] = this.igstAmount;
    data['lcb'] = this.lcb;
    data['lct'] = this.lct;
    return data;
  }
}

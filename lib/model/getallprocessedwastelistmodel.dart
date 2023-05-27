class GetAllProcessedWasteList {
  bool? status;
  List<Data>? data;

  GetAllProcessedWasteList({this.status, this.data});

  GetAllProcessedWasteList.fromJson(Map<String, dynamic> json) {
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
  String? bankBranchId;
  String? wasteProcessId;
  String? transactionId;
  String? tdate;
  String? transactionAmount;
  String? sgstAmount;
  String? cgstAmount;
  String? igstAmount;
  String? lcb;
  String? lct;
  String? branch;
  String? processName;
  String? machineName;

  Data(
      {this.id,
      this.bankBranchId,
      this.wasteProcessId,
      this.transactionId,
      this.tdate,
      this.transactionAmount,
      this.sgstAmount,
      this.cgstAmount,
      this.igstAmount,
      this.lcb,
      this.lct,
      this.branch,
      this.processName,
      this.machineName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankBranchId = json['bank_branch_id'];
    wasteProcessId = json['waste_process_id'];
    transactionId = json['transaction_id'];
    tdate = json['tdate'];
    transactionAmount = json['transaction_amount'];
    sgstAmount = json['sgst_amount'];
    cgstAmount = json['cgst_amount'];
    igstAmount = json['igst_amount'];
    lcb = json['lcb'];
    lct = json['lct'];
    branch = json['branch'];
    processName = json['process_name'];
    machineName = json['machine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_branch_id'] = this.bankBranchId;
    data['waste_process_id'] = this.wasteProcessId;
    data['transaction_id'] = this.transactionId;
    data['tdate'] = this.tdate;
    data['transaction_amount'] = this.transactionAmount;
    data['sgst_amount'] = this.sgstAmount;
    data['cgst_amount'] = this.cgstAmount;
    data['igst_amount'] = this.igstAmount;
    data['lcb'] = this.lcb;
    data['lct'] = this.lct;
    data['branch'] = this.branch;
    data['process_name'] = this.processName;
    data['machine_name'] = this.machineName;
    return data;
  }
}

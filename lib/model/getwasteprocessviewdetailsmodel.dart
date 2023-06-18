class GetWasteProcessViewDetailsModel {
  bool? status;
  Data? data;

  GetWasteProcessViewDetailsModel({this.status, this.data});

  GetWasteProcessViewDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  List<Cproducts>? cproducts;
  List<Gproducts>? gproducts;

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
      this.machineName,
      this.cproducts,
      this.gproducts});

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
    if (json['cproducts'] != null) {
      cproducts = <Cproducts>[];
      json['cproducts'].forEach((v) {
        cproducts!.add(new Cproducts.fromJson(v));
      });
    }
    if (json['gproducts'] != null) {
      gproducts = <Gproducts>[];
      json['gproducts'].forEach((v) {
        gproducts!.add(new Gproducts.fromJson(v));
      });
    }
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
    if (this.cproducts != null) {
      data['cproducts'] = this.cproducts!.map((v) => v.toJson()).toList();
    }
    if (this.gproducts != null) {
      data['gproducts'] = this.gproducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cproducts {
  String? productName;
  String? id;
  String? stockJournalId;
  String? productId;
  String? quom;
  String? qauom;
  String? rate;
  String? rateOn;
  String? total;
  String? gstPer;
  String? sgstAmount;
  String? cgstAmount;
  String? igstAmount;
  String? totalAmount;
  String? uom;
  String? auom;

  Cproducts(
      {this.productName,
      this.id,
      this.stockJournalId,
      this.productId,
      this.quom,
      this.qauom,
      this.rate,
      this.rateOn,
      this.total,
      this.gstPer,
      this.sgstAmount,
      this.cgstAmount,
      this.igstAmount,
      this.totalAmount,
      this.uom,
      this.auom});

  Cproducts.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    id = json['id'];
    stockJournalId = json['stock_journal_id'];
    productId = json['product_id'];
    quom = json['quom'];
    qauom = json['qauom'];
    rate = json['rate'];
    rateOn = json['rate_on'];
    total = json['total'];
    gstPer = json['gst_per'];
    sgstAmount = json['sgst_amount'];
    cgstAmount = json['cgst_amount'];
    igstAmount = json['igst_amount'];
    totalAmount = json['total_amount'];
    uom = json['uom'];
    auom = json['auom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['id'] = this.id;
    data['stock_journal_id'] = this.stockJournalId;
    data['product_id'] = this.productId;
    data['quom'] = this.quom;
    data['qauom'] = this.qauom;
    data['rate'] = this.rate;
    data['rate_on'] = this.rateOn;
    data['total'] = this.total;
    data['gst_per'] = this.gstPer;
    data['sgst_amount'] = this.sgstAmount;
    data['cgst_amount'] = this.cgstAmount;
    data['igst_amount'] = this.igstAmount;
    data['total_amount'] = this.totalAmount;
    data['uom'] = this.uom;
    data['auom'] = this.auom;
    return data;
  }
}

class Gproducts {
  String? productName;
  String? id;
  String? stockJournalId;
  String? productId;
  String? quom;
  String? qauom;
  String? rate;
  String? rateOn;
  String? total;
  String? gstPer;
  String? sgstAmount;
  String? cgstAmount;
  String? igstAmount;
  String? totalAmount;
  String? uom;
  String? auom;

  Gproducts(
      {this.productName,
      this.id,
      this.stockJournalId,
      this.productId,
      this.quom,
      this.qauom,
      this.rate,
      this.rateOn,
      this.total,
      this.gstPer,
      this.sgstAmount,
      this.cgstAmount,
      this.igstAmount,
      this.totalAmount,
      this.uom,
      this.auom});

  Gproducts.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    id = json['id'];
    stockJournalId = json['stock_journal_id'];
    productId = json['product_id'];
    quom = json['quom'];
    qauom = json['qauom'];
    rate = json['rate'];
    rateOn = json['rate_on'];
    total = json['total'];
    gstPer = json['gst_per'];
    sgstAmount = json['sgst_amount'];
    cgstAmount = json['cgst_amount'];
    igstAmount = json['igst_amount'];
    totalAmount = json['total_amount'];
    uom = json['uom'];
    auom = json['auom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['id'] = this.id;
    data['stock_journal_id'] = this.stockJournalId;
    data['product_id'] = this.productId;
    data['quom'] = this.quom;
    data['qauom'] = this.qauom;
    data['rate'] = this.rate;
    data['rate_on'] = this.rateOn;
    data['total'] = this.total;
    data['gst_per'] = this.gstPer;
    data['sgst_amount'] = this.sgstAmount;
    data['cgst_amount'] = this.cgstAmount;
    data['igst_amount'] = this.igstAmount;
    data['total_amount'] = this.totalAmount;
    data['uom'] = this.uom;
    data['auom'] = this.auom;
    return data;
  }
}

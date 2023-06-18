class GetPurchaseViewDetailsModel {
  bool? status;
  Data? data;

  GetPurchaseViewDetailsModel({this.status, this.data});

  GetPurchaseViewDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;
  List<Documents>? documents;

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
      this.lct,
      this.products,
      this.documents});

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
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
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
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productName;
  String? id;
  String? saleId;
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

  Products(
      {this.productName,
      this.id,
      this.saleId,
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

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    id = json['id'];
    saleId = json['sale_id'];
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
    data['sale_id'] = this.saleId;
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

class Documents {
  String? id;
  String? saleId;
  String? documentType;
  String? documentNo;
  String? documentPath;
  String? lcb;
  String? lct;

  Documents(
      {this.id,
      this.saleId,
      this.documentType,
      this.documentNo,
      this.documentPath,
      this.lcb,
      this.lct});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleId = json['sale_id'];
    documentType = json['document_type'];
    documentNo = json['document_no'];
    documentPath = json['document_path'];
    lcb = json['lcb'];
    lct = json['lct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sale_id'] = this.saleId;
    data['document_type'] = this.documentType;
    data['document_no'] = this.documentNo;
    data['document_path'] = this.documentPath;
    data['lcb'] = this.lcb;
    data['lct'] = this.lct;
    return data;
  }
}

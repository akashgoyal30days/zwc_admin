class Getallbankbranchmodel {
  bool? status;
  List<Data>? data;

  Getallbankbranchmodel({this.status, this.data});

  Getallbankbranchmodel.fromJson(Map<String, dynamic> json) {
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
  String? bankBranchTypeId;
  String? branchName;
  String? branchContact;
  String? branchEmail;
  String? branchAddress;
  String? areaId;
  String? isCollectionRequest;
  String? isDirectSubmission;
  String? isSale;
  String? isStockTransfer;
  String? isWasteProcessing;
  String? isPurchase;
  String? branchType;
  String? area;
  String? city;
  String? district;
  String? state;

  Data(
      {this.id,
      this.bankBranchTypeId,
      this.branchName,
      this.branchContact,
      this.branchEmail,
      this.branchAddress,
      this.areaId,
      this.isCollectionRequest,
      this.isDirectSubmission,
      this.isSale,
      this.isStockTransfer,
      this.isWasteProcessing,
      this.isPurchase,
      this.branchType,
      this.area,
      this.city,
      this.district,
      this.state});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankBranchTypeId = json['bank_branch_type_id'];
    branchName = json['branch_name'];
    branchContact = json['branch_contact'];
    branchEmail = json['branch_email'];
    branchAddress = json['branch_address'];
    areaId = json['area_id'];
    isCollectionRequest = json['is_collection_request'];
    isDirectSubmission = json['is_direct_submission'];
    isSale = json['is_sale'];
    isStockTransfer = json['is_stock_transfer'];
    isWasteProcessing = json['is_waste_processing'];
    isPurchase = json['is_purchase'];
    branchType = json['branch_type'];
    area = json['area'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_branch_type_id'] = this.bankBranchTypeId;
    data['branch_name'] = this.branchName;
    data['branch_contact'] = this.branchContact;
    data['branch_email'] = this.branchEmail;
    data['branch_address'] = this.branchAddress;
    data['area_id'] = this.areaId;
    data['is_collection_request'] = this.isCollectionRequest;
    data['is_direct_submission'] = this.isDirectSubmission;
    data['is_sale'] = this.isSale;
    data['is_stock_transfer'] = this.isStockTransfer;
    data['is_waste_processing'] = this.isWasteProcessing;
    data['is_purchase'] = this.isPurchase;
    data['branch_type'] = this.branchType;
    data['area'] = this.area;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    return data;
  }
}

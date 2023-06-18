class GetCollectionviewDetailsModel {
  bool? status;
  Data? data;

  GetCollectionviewDetailsModel({this.status, this.data});

  GetCollectionviewDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? collectionId;
  String? tdate;
  String? bankBranchId;
  String? userDetailId;
  String? transactionAmount;
  String? sgstAmount;
  String? cgstAmount;
  String? igstAmount;
  String? isDonation;
  String? lcb;
  String? lct;
  String? userRoleId;
  String? name;
  String? email;
  String? password;
  String? tempPassword;
  String? phoneNum;
  String? address;
  String? areaId;
  String? isActive;
  String? profileImage;
  String? ad1;
  String? ad2;
  String? ad3;
  String? ad4;
  String? ad5;
  String? ad6;
  String? ad7;
  String? ad8;
  String? ad9;
  String? ad10;
  String? isAddressEnt;
  String? bankBranchTypeId;
  String? branchName;
  String? branchContact;
  String? branchEmail;
  String? branchAddress;
  String? isCollectionRequest;
  String? isDirectSubmission;
  String? isSale;
  String? isStockTransfer;
  String? isWasteProcessing;
  String? isPurchase;
  List<Products>? products;
  List<EnvironmentSaved>? environmentSaved;
  List<CategoryWiseCollection>? categoryWiseCollection;

  Data(
      {this.id,
      this.collectionId,
      this.tdate,
      this.bankBranchId,
      this.userDetailId,
      this.transactionAmount,
      this.sgstAmount,
      this.cgstAmount,
      this.igstAmount,
      this.isDonation,
      this.lcb,
      this.lct,
      this.userRoleId,
      this.name,
      this.email,
      this.password,
      this.tempPassword,
      this.phoneNum,
      this.address,
      this.areaId,
      this.isActive,
      this.profileImage,
      this.ad1,
      this.ad2,
      this.ad3,
      this.ad4,
      this.ad5,
      this.ad6,
      this.ad7,
      this.ad8,
      this.ad9,
      this.ad10,
      this.isAddressEnt,
      this.bankBranchTypeId,
      this.branchName,
      this.branchContact,
      this.branchEmail,
      this.branchAddress,
      this.isCollectionRequest,
      this.isDirectSubmission,
      this.isSale,
      this.isStockTransfer,
      this.isWasteProcessing,
      this.isPurchase,
      this.products,
      this.environmentSaved,
      this.categoryWiseCollection});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collection_id'];
    tdate = json['tdate'];
    bankBranchId = json['bank_branch_id'];
    userDetailId = json['user_detail_id'];
    transactionAmount = json['transaction_amount'];
    sgstAmount = json['sgst_amount'];
    cgstAmount = json['cgst_amount'];
    igstAmount = json['igst_amount'];
    isDonation = json['is_donation'];
    lcb = json['lcb'];
    lct = json['lct'];
    userRoleId = json['user_role_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    tempPassword = json['temp_password'];
    phoneNum = json['phone_num'];
    address = json['address'];
    areaId = json['area_id'];
    isActive = json['is_active'];
    profileImage = json['profile_image'];
    ad1 = json['ad1'];
    ad2 = json['ad2'];
    ad3 = json['ad3'];
    ad4 = json['ad4'];
    ad5 = json['ad5'];
    ad6 = json['ad6'];
    ad7 = json['ad7'];
    ad8 = json['ad8'];
    ad9 = json['ad9'];
    ad10 = json['ad10'];
    isAddressEnt = json['is_address_ent'];
    bankBranchTypeId = json['bank_branch_type_id'];
    branchName = json['branch_name'];
    branchContact = json['branch_contact'];
    branchEmail = json['branch_email'];
    branchAddress = json['branch_address'];
    isCollectionRequest = json['is_collection_request'];
    isDirectSubmission = json['is_direct_submission'];
    isSale = json['is_sale'];
    isStockTransfer = json['is_stock_transfer'];
    isWasteProcessing = json['is_waste_processing'];
    isPurchase = json['is_purchase'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['environment_saved'] != null) {
      environmentSaved = <EnvironmentSaved>[];
      json['environment_saved'].forEach((v) {
        environmentSaved!.add(new EnvironmentSaved.fromJson(v));
      });
    }
    if (json['category_wise_collection'] != null) {
      categoryWiseCollection = <CategoryWiseCollection>[];
      json['category_wise_collection'].forEach((v) {
        categoryWiseCollection!.add(new CategoryWiseCollection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['collection_id'] = this.collectionId;
    data['tdate'] = this.tdate;
    data['bank_branch_id'] = this.bankBranchId;
    data['user_detail_id'] = this.userDetailId;
    data['transaction_amount'] = this.transactionAmount;
    data['sgst_amount'] = this.sgstAmount;
    data['cgst_amount'] = this.cgstAmount;
    data['igst_amount'] = this.igstAmount;
    data['is_donation'] = this.isDonation;
    data['lcb'] = this.lcb;
    data['lct'] = this.lct;
    data['user_role_id'] = this.userRoleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['temp_password'] = this.tempPassword;
    data['phone_num'] = this.phoneNum;
    data['address'] = this.address;
    data['area_id'] = this.areaId;
    data['is_active'] = this.isActive;
    data['profile_image'] = this.profileImage;
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    data['ad3'] = this.ad3;
    data['ad4'] = this.ad4;
    data['ad5'] = this.ad5;
    data['ad6'] = this.ad6;
    data['ad7'] = this.ad7;
    data['ad8'] = this.ad8;
    data['ad9'] = this.ad9;
    data['ad10'] = this.ad10;
    data['is_address_ent'] = this.isAddressEnt;
    data['bank_branch_type_id'] = this.bankBranchTypeId;
    data['branch_name'] = this.branchName;
    data['branch_contact'] = this.branchContact;
    data['branch_email'] = this.branchEmail;
    data['branch_address'] = this.branchAddress;
    data['is_collection_request'] = this.isCollectionRequest;
    data['is_direct_submission'] = this.isDirectSubmission;
    data['is_sale'] = this.isSale;
    data['is_stock_transfer'] = this.isStockTransfer;
    data['is_waste_processing'] = this.isWasteProcessing;
    data['is_purchase'] = this.isPurchase;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.environmentSaved != null) {
      data['environment_saved'] =
          this.environmentSaved!.map((v) => v.toJson()).toList();
    }
    if (this.categoryWiseCollection != null) {
      data['category_wise_collection'] =
          this.categoryWiseCollection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productName;
  String? id;
  String? branchCollectionDetailId;
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
      this.branchCollectionDetailId,
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
    branchCollectionDetailId = json['branch_collection_detail_id'];
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
    data['branch_collection_detail_id'] = this.branchCollectionDetailId;
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

class EnvironmentSaved {
  String? environmentParameter;
  String? paramAmount;

  EnvironmentSaved({this.environmentParameter, this.paramAmount});

  EnvironmentSaved.fromJson(Map<String, dynamic> json) {
    environmentParameter = json['environment_parameter'];
    paramAmount = json['param_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['environment_parameter'] = this.environmentParameter;
    data['param_amount'] = this.paramAmount;
    return data;
  }
}

class CategoryWiseCollection {
  String? param;
  int? amount;

  CategoryWiseCollection({this.param, this.amount});

  CategoryWiseCollection.fromJson(Map<String, dynamic> json) {
    param = json['param'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['param'] = this.param;
    data['amount'] = this.amount;
    return data;
  }
}

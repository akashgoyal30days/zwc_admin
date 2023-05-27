class GetAllProductList {
  bool? status;
  List<Data>? data;

  GetAllProductList({this.status, this.data});

  GetAllProductList.fromJson(Map<String, dynamic> json) {
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
  String? productCategoryId;
  String? productName;
  String? unitId;
  String? aunitId;
  String? conversion;
  String? salePrice;
  String? purchasePrice;
  String? gstSlabId;
  String? wasteTypeId;
  String? isActive;
  String? category;
  String? unit;
  String? aunit;
  String? gst;
  String? wasteType;

  Data(
      {this.id,
      this.productCategoryId,
      this.productName,
      this.unitId,
      this.aunitId,
      this.conversion,
      this.salePrice,
      this.purchasePrice,
      this.gstSlabId,
      this.wasteTypeId,
      this.isActive,
      this.category,
      this.unit,
      this.aunit,
      this.gst,
      this.wasteType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCategoryId = json['product_category_id'];
    productName = json['product_name'];
    unitId = json['unit_id'];
    aunitId = json['aunit_id'];
    conversion = json['conversion'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    gstSlabId = json['gst_slab_id'];
    wasteTypeId = json['waste_type_id'];
    isActive = json['is_active'];
    category = json['category'];
    unit = json['unit'];
    aunit = json['aunit'];
    gst = json['gst'];
    wasteType = json['waste_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_category_id'] = this.productCategoryId;
    data['product_name'] = this.productName;
    data['unit_id'] = this.unitId;
    data['aunit_id'] = this.aunitId;
    data['conversion'] = this.conversion;
    data['sale_price'] = this.salePrice;
    data['purchase_price'] = this.purchasePrice;
    data['gst_slab_id'] = this.gstSlabId;
    data['waste_type_id'] = this.wasteTypeId;
    data['is_active'] = this.isActive;
    data['category'] = this.category;
    data['unit'] = this.unit;
    data['aunit'] = this.aunit;
    data['gst'] = this.gst;
    data['waste_type'] = this.wasteType;
    return data;
  }
}

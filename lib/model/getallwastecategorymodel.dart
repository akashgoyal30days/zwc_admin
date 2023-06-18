class GetAllWasteCategoryModel {
  bool? status;
  List<Data>? data;

  GetAllWasteCategoryModel({this.status, this.data});

  GetAllWasteCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryName;
  String? categoryImage;
  String? categoryImageName;
  String? parentCategory;
  String? isActive;
  String? parent;

  Data(
      {this.id,
      this.categoryName,
      this.categoryImage,
      this.categoryImageName,
      this.parentCategory,
      this.isActive,
      this.parent});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryImageName = json['category_image_name'];
    parentCategory = json['parent_category'];
    isActive = json['is_active'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['category_image_name'] = this.categoryImageName;
    data['parent_category'] = this.parentCategory;
    data['is_active'] = this.isActive;
    data['parent'] = this.parent;
    return data;
  }
}

// To parse this JSON data, do
//
//     final getstockreportbycategoryModel = getstockreportbycategoryModelFromJson(jsonString);

import 'dart:convert';

GetstockreportbycategoryModel getstockreportbycategoryModelFromJson(String str) => GetstockreportbycategoryModel.fromJson(json.decode(str));

String getstockreportbycategoryModelToJson(GetstockreportbycategoryModel data) => json.encode(data.toJson());

class GetstockreportbycategoryModel {
    bool? status;
    List<Datum>? data;

    GetstockreportbycategoryModel({
        this.status,
        this.data,
    });

    factory GetstockreportbycategoryModel.fromJson(Map<String, dynamic> json) => GetstockreportbycategoryModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? categoryName;
    String? categoryImage;
    dynamic outQuantity;
    dynamic inQuantity;
    dynamic balance;
    dynamic opening;
    int? closing;

    Datum({
        this.id,
        this.categoryName,
        this.categoryImage,
        this.outQuantity,
        this.inQuantity,
        this.balance,
        this.opening,
        this.closing,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        outQuantity: json["out_quantity"],
        inQuantity: json["in_quantity"],
        balance: json["balance"],
        opening: json["opening"],
        closing: json["closing"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
        "out_quantity": outQuantity,
        "in_quantity": inQuantity,
        "balance": balance,
        "opening": opening,
        "closing": closing,
    };
}

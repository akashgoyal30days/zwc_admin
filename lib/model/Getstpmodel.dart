// To parse this JSON data, do
//
//     final getStPdata = getStPdataFromJson(jsonString);

import 'dart:convert';

List<GetStPdata> getStPdataFromJson(String str) => List<GetStPdata>.from(json.decode(str).map((x) => GetStPdata.fromJson(x)));

String getStPdataToJson(List<GetStPdata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStPdata {
    String? id;
    String? bankBranchId;
    String? deviceType;
    String? deviceName;
    String? deviceIdSmarden;
    String? isActive;
    DataClass? data;

    GetStPdata({
        this.id,
        this.bankBranchId,
        this.deviceType,
        this.deviceName,
        this.deviceIdSmarden,
        this.isActive,
        this.data,
    });

    factory GetStPdata.fromJson(Map<String, dynamic> json) => GetStPdata(
        id: json["id"],
        bankBranchId: json["bank_branch_id"],
        deviceType: json["device_type"],
        deviceName: json["device_name"],
        deviceIdSmarden: json["device_id_smarden"],
        isActive: json["is_active"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bank_branch_id": bankBranchId,
        "device_type": deviceType,
        "device_name": deviceName,
        "device_id_smarden": deviceIdSmarden,
        "is_active": isActive,
        "data": data,
    };
}

class DataClass {
    Latest? latest;
    List<Latest>? history;
    Sum? sum;

    DataClass({
        this.latest,
        this.history,
        this.sum,
    });

    factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
        latest: json["latest"] == null ? null : Latest.fromJson(json["latest"]),
        history: json["history"] == null ? [] : List<Latest>.from(json["history"]!.map((x) => Latest.fromJson(x))),
        sum: json["sum"] == null ? null : Sum.fromJson(json["sum"]),
    );

    Map<String, dynamic> toJson() => {
        "latest": latest?.toJson(),
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
        "sum": sum?.toJson(),
    };
}

class Latest {
    DateTime? date;
    Params? params;

    Latest({
        this.date,
        this.params,
    });

    factory Latest.fromJson(Map<String, dynamic> json) => Latest(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "params": params?.toJson(),
    };
}

class Params {
    double? volume;

    Params({
        this.volume,
    });

    factory Params.fromJson(Map<String, dynamic> json) => Params(
        volume: json["volume"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "volume": volume,
    };
}

class Sum {
    Params? params;

    Sum({
        this.params,
    });

    factory Sum.fromJson(Map<String, dynamic> json) => Sum(
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
    );

    Map<String, dynamic> toJson() => {
        "params": params?.toJson(),
    };
}

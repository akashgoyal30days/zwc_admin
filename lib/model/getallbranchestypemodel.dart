class Getallbranchestypemodel {
  bool? status;
  List<Data>? data;

  Getallbranchestypemodel({this.status, this.data});

  Getallbranchestypemodel.fromJson(Map<String, dynamic> json) {
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
  String? branchType;
  String? dataFrequency;
  String? isSegregation;
  String? defaultFieldGrouping;
  String? isActive;

  Data(
      {this.id,
      this.branchType,
      this.dataFrequency,
      this.isSegregation,
      this.defaultFieldGrouping,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchType = json['branch_type'];
    dataFrequency = json['data_frequency'];
    isSegregation = json['is_segregation'];
    defaultFieldGrouping = json['default_field_grouping'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_type'] = this.branchType;
    data['data_frequency'] = this.dataFrequency;
    data['is_segregation'] = this.isSegregation;
    data['default_field_grouping'] = this.defaultFieldGrouping;
    data['is_active'] = this.isActive;
    return data;
  }
}

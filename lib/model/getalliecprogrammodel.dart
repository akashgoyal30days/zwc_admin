class GetAllIECProgramsModel {
  bool? status;
  List<Data>? data;

  GetAllIECProgramsModel({this.status, this.data});

  GetAllIECProgramsModel.fromJson(Map<String, dynamic> json) {
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
  String? programName;

  Data({this.id, this.programName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    programName = json['program_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['program_name'] = this.programName;
    return data;
  }
}

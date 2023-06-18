class GetAllWasteProcessModel {
  bool? status;
  List<Data>? data;

  GetAllWasteProcessModel({this.status, this.data});

  GetAllWasteProcessModel.fromJson(Map<String, dynamic> json) {
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
  String? processName;
  String? machineName;

  Data({this.id, this.processName, this.machineName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    processName = json['process_name'];
    machineName = json['machine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['process_name'] = this.processName;
    data['machine_name'] = this.machineName;
    return data;
  }
}

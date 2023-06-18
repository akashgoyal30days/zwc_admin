class GetUserQrDetailsModel {
  bool? status;
  Data? data;

  GetUserQrDetailsModel({this.status, this.data});

  GetUserQrDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? userDetailId;
  String? sqr;
  String? nsqr;

  Data({this.id, this.userDetailId, this.sqr, this.nsqr});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userDetailId = json['user_detail_id'];
    sqr = json['sqr'];
    nsqr = json['nsqr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_detail_id'] = this.userDetailId;
    data['sqr'] = this.sqr;
    data['nsqr'] = this.nsqr;
    return data;
  }
}

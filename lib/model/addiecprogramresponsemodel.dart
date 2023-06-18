class AddIECprogramResponseModel {
  bool? status;
  String? message;
  int? id;

  AddIECprogramResponseModel({this.status, this.message, this.id});

  AddIECprogramResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['id'] = this.id;
    return data;
  }
}

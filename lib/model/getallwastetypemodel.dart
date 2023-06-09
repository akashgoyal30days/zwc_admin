class Getproductwastetypemodel {
  bool? status;
  List<Data>? data;

  Getproductwastetypemodel({this.status, this.data});

  Getproductwastetypemodel.fromJson(Map<String, dynamic> json) {
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
  String? waste;

  Data({this.id, this.waste});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    waste = json['waste'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['waste'] = this.waste;
    return data;
  }
}

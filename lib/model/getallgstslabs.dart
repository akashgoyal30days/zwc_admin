class Getallgstslabs {
  bool? status;
  List<Data>? data;

  Getallgstslabs({this.status, this.data});

  Getallgstslabs.fromJson(Map<String, dynamic> json) {
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
  String? gst;
  String? sgst;
  String? cgst;
  String? igst;

  Data({this.id, this.gst, this.sgst, this.cgst, this.igst});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gst = json['gst'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    igst = json['igst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gst'] = this.gst;
    data['sgst'] = this.sgst;
    data['cgst'] = this.cgst;
    data['igst'] = this.igst;
    return data;
  }
}

class GetAllIECProgramTopicsModel {
  bool? status;
  List<Data>? data;

  GetAllIECProgramTopicsModel({this.status, this.data});

  GetAllIECProgramTopicsModel.fromJson(Map<String, dynamic> json) {
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
  String? iecProgramId;
  String? topicName;
  String? topicPriority;
  String? programName;

  Data(
      {this.id,
      this.iecProgramId,
      this.topicName,
      this.topicPriority,
      this.programName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iecProgramId = json['iec_program_id'];
    topicName = json['topic_name'];
    topicPriority = json['topic_priority'];
    programName = json['program_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iec_program_id'] = this.iecProgramId;
    data['topic_name'] = this.topicName;
    data['topic_priority'] = this.topicPriority;
    data['program_name'] = this.programName;
    return data;
  }
}

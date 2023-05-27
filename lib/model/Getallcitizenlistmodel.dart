class GetAllCiitizenList {
  bool? status;
  List<Data>? data;
  List<Additional>? additional;

  GetAllCiitizenList({this.status, this.data, this.additional});

  GetAllCiitizenList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['additional'] != null) {
      additional = <Additional>[];
      json['additional'].forEach((v) {
        additional!.add(new Additional.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.additional != null) {
      data['additional'] = this.additional!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? email;
  String? phoneNum;
  String? address;
  String? profileImage;
  String? isActive;
  String? ad1;
  String? ad2;
  String? ad3;
  String? ad4;
  String? roleName;
  String? area;
  String? city;
  String? pincode;
  String? district;
  String? state;
  String? country;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phoneNum,
      this.address,
      this.profileImage,
      this.isActive,
      this.ad1,
      this.ad2,
      this.ad3,
      this.ad4,
      this.roleName,
      this.area,
      this.city,
      this.pincode,
      this.district,
      this.state,
      this.country});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNum = json['phone_num'];
    address = json['address'];
    profileImage = json['profile_image'];
    isActive = json['is_active'];
    ad1 = json['ad1'];
    ad2 = json['ad2'];
    ad3 = json['ad3'];
    ad4 = json['ad4'];
    roleName = json['role_name'];
    area = json['area'];
    city = json['city'];
    pincode = json['pincode'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_num'] = this.phoneNum;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['is_active'] = this.isActive;
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    data['ad3'] = this.ad3;
    data['ad4'] = this.ad4;
    data['role_name'] = this.roleName;
    data['area'] = this.area;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class Additional {
  String? ad1;
  String? ad2;
  String? ad3;
  String? ad4;

  Additional({this.ad1, this.ad2, this.ad3, this.ad4});

  Additional.fromJson(Map<String, dynamic> json) {
    ad1 = json['ad1'];
    ad2 = json['ad2'];
    ad3 = json['ad3'];
    ad4 = json['ad4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    data['ad3'] = this.ad3;
    data['ad4'] = this.ad4;
    return data;
  }
}
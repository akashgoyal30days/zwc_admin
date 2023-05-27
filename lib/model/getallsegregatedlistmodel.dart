class Getallsegregatedlist {
  bool? status;
  List<Data>? data;

  Getallsegregatedlist({this.status, this.data});

  Getallsegregatedlist.fromJson(Map<String, dynamic> json) {
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
  String? bankBranchId;
  String? userDetailId;
  String? cdate;
  String? status;
  String? userRoleId;
  String? name;
  String? email;
  String? password;
  String? tempPassword;
  String? phoneNum;
  String? address;
  String? areaId;
  String? isActive;
  String? profileImage;
  String? ad1;
  String? ad2;
  String? ad3;
  String? ad4;
  String? ad5;
  String? ad6;
  String? ad7;
  String? ad8;
  String? ad9;
  String? ad10;
  String? isAddressEnt;
  String? lct;

  Data(
      {this.id,
      this.bankBranchId,
      this.userDetailId,
      this.cdate,
      this.status,
      this.userRoleId,
      this.name,
      this.email,
      this.password,
      this.tempPassword,
      this.phoneNum,
      this.address,
      this.areaId,
      this.isActive,
      this.profileImage,
      this.ad1,
      this.ad2,
      this.ad3,
      this.ad4,
      this.ad5,
      this.ad6,
      this.ad7,
      this.ad8,
      this.ad9,
      this.ad10,
      this.isAddressEnt,
      this.lct});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankBranchId = json['bank_branch_id'];
    userDetailId = json['user_detail_id'];
    cdate = json['cdate'];
    status = json['status'];
    userRoleId = json['user_role_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    tempPassword = json['temp_password'];
    phoneNum = json['phone_num'];
    address = json['address'];
    areaId = json['area_id'];
    isActive = json['is_active'];
    profileImage = json['profile_image'];
    ad1 = json['ad1'];
    ad2 = json['ad2'];
    ad3 = json['ad3'];
    ad4 = json['ad4'];
    ad5 = json['ad5'];
    ad6 = json['ad6'];
    ad7 = json['ad7'];
    ad8 = json['ad8'];
    ad9 = json['ad9'];
    ad10 = json['ad10'];
    isAddressEnt = json['is_address_ent'];
    lct = json['lct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_branch_id'] = this.bankBranchId;
    data['user_detail_id'] = this.userDetailId;
    data['cdate'] = this.cdate;
    data['status'] = this.status;
    data['user_role_id'] = this.userRoleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['temp_password'] = this.tempPassword;
    data['phone_num'] = this.phoneNum;
    data['address'] = this.address;
    data['area_id'] = this.areaId;
    data['is_active'] = this.isActive;
    data['profile_image'] = this.profileImage;
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    data['ad3'] = this.ad3;
    data['ad4'] = this.ad4;
    data['ad5'] = this.ad5;
    data['ad6'] = this.ad6;
    data['ad7'] = this.ad7;
    data['ad8'] = this.ad8;
    data['ad9'] = this.ad9;
    data['ad10'] = this.ad10;
    data['is_address_ent'] = this.isAddressEnt;
    data['lct'] = this.lct;
    return data;
  }
}

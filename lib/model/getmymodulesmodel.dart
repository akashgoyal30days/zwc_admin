class GetMyModulesModel {
  bool? status;
  List<ModuleData>? data;

  GetMyModulesModel({this.status, this.data});

  GetMyModulesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ModuleData>[];
      json['data'].forEach((v) {
        data!.add(new ModuleData.fromJson(v));
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

class ModuleData {
  String? userRoleId;
  String? systemModuleId;
  int? isAdd;
  int? isEdit;
  int? isView;
  int? isDelete;
  String? name;

  ModuleData(
      {this.userRoleId,
      this.systemModuleId,
      this.isAdd,
      this.isEdit,
      this.isView,
      this.isDelete,
      this.name});

  ModuleData.fromJson(Map<String, dynamic> json) {
    userRoleId = json['user_role_id'];
    systemModuleId = json['system_module_id'];
    isAdd = json['is_add'];
    isEdit = json['is_edit'];
    isView = json['is_view'];
    isDelete = json['is_delete'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_role_id'] = this.userRoleId;
    data['system_module_id'] = this.systemModuleId;
    data['is_add'] = this.isAdd;
    data['is_edit'] = this.isEdit;
    data['is_view'] = this.isView;
    data['is_delete'] = this.isDelete;
    data['name'] = this.name;
    return data;
  }
}

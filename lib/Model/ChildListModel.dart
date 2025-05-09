class ChildListModel {
  bool? status;
  List<ChildData>? childData;

  ChildListModel({this.status, this.childData});

  ChildListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      childData = <ChildData>[];
      json['data'].forEach((v) {
        childData!.add(new ChildData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.childData != null) {
      data['data'] = this.childData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildData {
  int? id;
  String? name;
  int? age;
  String? gender;
  int? parentId;
  int? isParent;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ChildData(
      {this.id,
        this.name,
        this.age,
        this.gender,
        this.parentId,
        this.isParent,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ChildData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    parentId = json['parent_id'];
    isParent = json['is_parent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['parent_id'] = this.parentId;
    data['is_parent'] = this.isParent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

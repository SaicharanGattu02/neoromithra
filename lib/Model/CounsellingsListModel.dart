class CounsellingsListModel {
  bool? status;
  List<CounsellingsList>? counsellingslist;

  CounsellingsListModel({this.status, this.counsellingslist});

  CounsellingsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      counsellingslist = <CounsellingsList>[];
      json['data'].forEach((v) {
        counsellingslist!.add(new CounsellingsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.counsellingslist != null) {
      data['data'] = this.counsellingslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CounsellingsList {
  int? id;
  String? type;
  String? name;
  int? amount;
  String? description;
  String? keyAreaFocus;
  String? benefits;
  String? image;
  String? appType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CounsellingsList(
      {this.id,
        this.type,
        this.name,
        this.amount,
        this.description,
        this.keyAreaFocus,
        this.benefits,
        this.image,
        this.appType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  CounsellingsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    amount = json['amount'];
    description = json['description'];
    keyAreaFocus = json['key_area_focus'];
    benefits = json['benefits'];
    image = json['image'];
    appType = json['app_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['key_area_focus'] = this.keyAreaFocus;
    data['benefits'] = this.benefits;
    data['image'] = this.image;
    data['app_type'] = this.appType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

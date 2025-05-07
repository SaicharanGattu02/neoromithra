class TherapiesListModel {
  bool? status;
  List<TherapiesList>? therapieslist;

  TherapiesListModel({this.status, this.therapieslist});

  TherapiesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      therapieslist = <TherapiesList>[];
      json['data'].forEach((v) {
        therapieslist!.add(new TherapiesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.therapieslist != null) {
      data['data'] = this.therapieslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TherapiesList {
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

  TherapiesList(
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

  TherapiesList.fromJson(Map<String, dynamic> json) {
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

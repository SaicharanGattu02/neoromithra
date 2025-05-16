class TherapiesListModel {
  bool? status;
  TherapiesData? data;

  TherapiesListModel({this.status, this.data});

  TherapiesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? TherapiesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TherapiesData {
  int? currentPage;
  List<TherapiesList>? therapiesList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  TherapiesData({
    this.currentPage,
    this.therapiesList,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  TherapiesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      therapiesList = <TherapiesList>[];
      json['data'].forEach((v) {
        therapiesList!.add(TherapiesList.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Link>[];
      json['links'].forEach((v) {
        links!.add(Link.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (therapiesList != null) {
      data['data'] = therapiesList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
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

  TherapiesList({
    this.id,
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
    this.deletedAt,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['amount'] = amount;
    data['description'] = description;
    data['key_area_focus'] = keyAreaFocus;
    data['benefits'] = benefits;
    data['image'] = image;
    data['app_type'] = appType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  Link.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
class ChildListModel {
  bool? status;
  ChildPaginationData? childData;

  ChildListModel({this.status, this.childData});

  ChildListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    childData = json['data'] != null ? ChildPaginationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (childData != null) {
      data['data'] = childData!.toJson();
    }
    return data;
  }
}

class ChildPaginationData {
  int? currentPage;
  List<ChildData>? children;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<PageLink>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ChildPaginationData({
    this.currentPage,
    this.children,
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

  ChildPaginationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      children = <ChildData>[];
      json['data'].forEach((v) {
        children!.add(ChildData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <PageLink>[];
      json['links'].forEach((v) {
        links!.add(PageLink.fromJson(v));
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
    final Map<String, dynamic> data = {};
    data['current_page'] = currentPage;
    if (children != null) {
      data['data'] = children!.map((v) => v.toJson()).toList();
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

  ChildData({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.parentId,
    this.isParent,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['gender'] = gender;
    data['parent_id'] = parentId;
    data['is_parent'] = isParent;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class PageLink {
  String? url;
  String? label;
  bool? active;

  PageLink({this.url, this.label, this.active});

  PageLink.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

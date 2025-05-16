class AddressResponse {
  final bool status;
  final AddressData? data;

  AddressResponse({
    required this.status,
    this.data,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      status: json['status'] ?? false,
      data: json['data'] != null ? AddressData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class AddressData {
  final int? currentPage;
  final List<Address>? addresses;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  AddressData({
    this.currentPage,
    this.addresses,
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

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      currentPage: json['current_page'],
      addresses: (json['data'] as List<dynamic>?)?.map((e) => Address.fromJson(e)).toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>?)?.map((e) => Link.fromJson(e)).toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': addresses?.map((v) => v.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((v) => v.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class Address {
  final int id;
  final int uid;
  final String flatNo;
  final String street;
  final String area;
  final String landmark;
  final int pincode;
  final int typeOfAddress;
  final String locationAccess;

  Address({
    required this.id,
    required this.uid,
    required this.flatNo,
    required this.street,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.typeOfAddress,
    required this.locationAccess,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? 0,
      flatNo: json['Flat_no'] ?? '',
      street: json['street'] ?? '',
      area: json['area'] ?? '',
      landmark: json['landmark'] ?? '',
      pincode: json['pincode'] ?? 0,
      typeOfAddress: json['type_of_address'] ?? 0,
      locationAccess: json['location_access'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'Flat_no': flatNo,
      'street': street,
      'area': area,
      'landmark': landmark,
      'pincode': pincode,
      'type_of_address': typeOfAddress,
      'location_access': locationAccess,
    };
  }
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
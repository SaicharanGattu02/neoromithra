class ServiceModel {
  final int id;
  final String type;
  final String name;
  final String amount;
  final String description;
  final String keyAreaFocus;
  final String benefits;
  final String image;
  final String service_pic_url;
  final String? appType;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ServiceModel({
    required this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.description,
    required this.keyAreaFocus,
    required this.benefits,
    required this.image,
    required this.service_pic_url,
    this.appType,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      amount: json['amount'],
      description: json['description'],
      keyAreaFocus: json['key_area_focus'],
      benefits: json['benefits'],
      image: json['image'],
      service_pic_url: json['service_pic_url'],
      appType: json['app_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'amount': amount,
      'description': description,
      'key_area_focus': keyAreaFocus,
      'benefits': benefits,
      'image': image,
      'service_pic_url': service_pic_url,
      'app_type': appType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}

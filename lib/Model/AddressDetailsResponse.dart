class AddressDetailsResponse {
  final bool status;
  final AddressDetails? data;

  AddressDetailsResponse({
    required this.status,
    required this.data,
  });

  factory AddressDetailsResponse.fromJson(Map<String, dynamic> json) {
    return AddressDetailsResponse(
      status: json['status'] ?? false,
      data: json['data'] != null ? AddressDetails.fromJson(json['data']) : null,
    );
  }
}

class AddressDetails {
  final int id;
  final int uid;
  final String flatNo;
  final String street;
  final String area;
  final String landmark;
  final String pincode;
  final int typeOfAddress;
  final String locationAccess;

  AddressDetails({
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

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? 0,
      flatNo: json['Flat_no'] ?? '',
      street: json['street'] ?? '',
      area: json['area'] ?? '',
      landmark: json['landmark'] ?? '',
      pincode: json['pincode'].toString(),
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

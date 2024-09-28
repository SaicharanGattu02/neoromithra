class AddressListModel {
  List<Address>? address;
  bool? status;

  AddressListModel({this.address, this.status});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Address {
  int? id;
  int? uid;
  String? flatNo;
  String? street;
  String? area;
  String? landmark;
  int? pincode;
  int? typeOfAddress;

  Address(
      {this.id,
        this.uid,
        this.flatNo,
        this.street,
        this.area,
        this.landmark,
        this.pincode,
        this.typeOfAddress});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    flatNo = json['Flat_no'];
    street = json['street'];
    area = json['area'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    typeOfAddress = json['type_of_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['Flat_no'] = this.flatNo;
    data['street'] = this.street;
    data['area'] = this.area;
    data['landmark'] = this.landmark;
    data['pincode'] = this.pincode;
    data['type_of_address'] = this.typeOfAddress;
    return data;
  }
}

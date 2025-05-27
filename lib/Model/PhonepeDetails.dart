class PhonepeDetails {
  bool? status;
  List<Keys>? keys;

  PhonepeDetails({this.status, this.keys});

  PhonepeDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['keys'] != null) {
      keys = <Keys>[];
      json['keys'].forEach((v) {
        keys!.add(new Keys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.keys != null) {
      data['keys'] = this.keys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Keys {
  int? id;
  String? pHONEPEMERCHANTID;
  String? pHONEPEMERCHANTUSERID;
  String? pHONEPEENV;
  String? pHONEPESALTKEY;
  int? pHONEPESALTINDEX;
  String? pHONEPECALLBACKURL;
  String? pHONEPEBASEURL;
  String? saasId;
  String? createdAt;
  Null? updatedAt;

  Keys(
      {this.id,
        this.pHONEPEMERCHANTID,
        this.pHONEPEMERCHANTUSERID,
        this.pHONEPEENV,
        this.pHONEPESALTKEY,
        this.pHONEPESALTINDEX,
        this.pHONEPECALLBACKURL,
        this.pHONEPEBASEURL,
        this.saasId,
        this.createdAt,
        this.updatedAt});

  Keys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pHONEPEMERCHANTID = json['PHONEPE_MERCHANT_ID'];
    pHONEPEMERCHANTUSERID = json['PHONEPE_MERCHANT_USER_ID'];
    pHONEPEENV = json['PHONEPE_ENV'];
    pHONEPESALTKEY = json['PHONEPE_SALT_KEY'];
    pHONEPESALTINDEX = json['PHONEPE_SALT_INDEX'];
    pHONEPECALLBACKURL = json['PHONEPE_CALLBACK_URL'];
    pHONEPEBASEURL = json['PHONEPE_BASE_URL'];
    saasId = json['saas_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PHONEPE_MERCHANT_ID'] = this.pHONEPEMERCHANTID;
    data['PHONEPE_MERCHANT_USER_ID'] = this.pHONEPEMERCHANTUSERID;
    data['PHONEPE_ENV'] = this.pHONEPEENV;
    data['PHONEPE_SALT_KEY'] = this.pHONEPESALTKEY;
    data['PHONEPE_SALT_INDEX'] = this.pHONEPESALTINDEX;
    data['PHONEPE_CALLBACK_URL'] = this.pHONEPECALLBACKURL;
    data['PHONEPE_BASE_URL'] = this.pHONEPEBASEURL;
    data['saas_id'] = this.saasId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

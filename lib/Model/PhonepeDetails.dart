class PhonepeDetails {
  bool? status;
  List<PhonepeKeys>? phonpekeys;

  PhonepeDetails({this.status, this.phonpekeys});

  PhonepeDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      phonpekeys = <PhonepeKeys>[];
      json['data'].forEach((v) {
        phonpekeys!.add(new PhonepeKeys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.phonpekeys != null) {
      data['data'] = this.phonpekeys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhonepeKeys {
  int? id;
  String? env;
  String? appId;
  String? merchantId;
  String? saltKey;
  int? saltIndex;

  PhonepeKeys(
      {this.id,
        this.env,
        this.appId,
        this.merchantId,
        this.saltKey,
        this.saltIndex});

  PhonepeKeys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    env = json['env'];
    appId = json['appId'];
    merchantId = json['merchantId'];
    saltKey = json['saltKey'];
    saltIndex = json['saltIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['env'] = this.env;
    data['appId'] = this.appId;
    data['merchantId'] = this.merchantId;
    data['saltKey'] = this.saltKey;
    data['saltIndex'] = this.saltIndex;
    return data;
  }
}

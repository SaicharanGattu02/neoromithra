class PhonepeDetails {
  bool? status;
  List<Data>? data;

  PhonepeDetails({this.status, this.data});

  PhonepeDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? env;
  String? appId;
  String? merchantId;
  String? saltKey;
  int? saltIndex;

  Data(
      {this.id,
        this.env,
        this.appId,
        this.merchantId,
        this.saltKey,
        this.saltIndex});

  Data.fromJson(Map<String, dynamic> json) {
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

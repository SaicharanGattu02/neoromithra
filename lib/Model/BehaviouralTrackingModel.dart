class BehaviouralTrackingModel {
  bool? status;
  List<Details>? details;

  BehaviouralTrackingModel({this.status, this.details});

  BehaviouralTrackingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  int? pid;
  int? uid;
  int? aid;
  String? dataDetails;
  String? details;
  String? pageSource;
  String? pname;
  String? uname;

  Details(
      {this.id,
        this.pid,
        this.uid,
        this.aid,
        this.dataDetails,
        this.details,
        this.pageSource,
        this.pname,
        this.uname});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    uid = json['uid'];
    aid = json['aid'];
    dataDetails = json['data_details'];
    details = json['details'];
    pageSource = json['page_source'];
    pname = json['pname'];
    uname = json['uname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['uid'] = this.uid;
    data['aid'] = this.aid;
    data['data_details'] = this.dataDetails;
    data['details'] = this.details;
    data['page_source'] = this.pageSource;
    data['pname'] = this.pname;
    data['uname'] = this.uname;
    return data;
  }
}

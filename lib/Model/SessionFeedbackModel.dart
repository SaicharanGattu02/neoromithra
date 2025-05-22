class SessionFeedbackModel {
  bool? status;
  List<SessionFeedback>? sessionFeedback;

  SessionFeedbackModel({this.status, this.sessionFeedback});

  SessionFeedbackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      sessionFeedback = <SessionFeedback>[];
      json['data'].forEach((v) {
        sessionFeedback!.add(new SessionFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sessionFeedback != null) {
      data['data'] = this.sessionFeedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SessionFeedback {
  int? id;
  int? staffId;
  String? text;
  int? assignedId;
  int? appId;
  String? createdAt;
  String? updateAt;

  SessionFeedback(
      {this.id,
        this.staffId,
        this.text,
        this.assignedId,
        this.appId,
        this.createdAt,
        this.updateAt});

  SessionFeedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    text = json['text'];
    assignedId = json['assigned_id'];
    appId = json['app_id'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['text'] = this.text;
    data['assigned_id'] = this.assignedId;
    data['app_id'] = this.appId;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}

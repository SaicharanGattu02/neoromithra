class ReviewListModel {
  bool? status;
  List<Review>? review;

  ReviewListModel({this.status, this.review});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  int? id;
  int? appId;
  int? userId;
  String? userName;
  int? rating;
  String? details;
  String? pageSource;
  String? createdAt;

  Review(
      {this.id,
        this.appId,
        this.userId,
        this.userName,
        this.rating,
        this.details,
        this.pageSource,
        this.createdAt});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    rating = json['rating'];
    details = json['details'];
    pageSource = json['page_source'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['rating'] = this.rating;
    data['details'] = this.details;
    data['page_source'] = this.pageSource;
    data['created_at'] = this.createdAt;
    return data;
  }
}

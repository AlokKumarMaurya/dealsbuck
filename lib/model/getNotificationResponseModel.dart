// To parse this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';

GetNotificationModel getNotificationModelFromJson(String str) => GetNotificationModel.fromJson(json.decode(str));

String getNotificationModelToJson(GetNotificationModel data) => json.encode(data.toJson());

class GetNotificationModel {
  GetNotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.title,
    required this.body,
    required this.brandName,
    required this.brandImagePath,
    required this.city,
    required this.notificationTime,
    required this.distance,
  });

  String title;
  String body;
  String brandName;
  String brandImagePath;
  String city;
  DateTime notificationTime;
  double distance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    body: json["body"],
    brandName: json["brand_name"],
    brandImagePath: json["brand_image_path"],
    city: json["city"],
    notificationTime: DateTime.parse(json["notification_time"]),
    distance: json["distance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "brand_name": brandName,
    "brand_image_path": brandImagePath,
    "city": city,
    "notification_time": notificationTime.toIso8601String(),
    "distance": distance,
  };
}

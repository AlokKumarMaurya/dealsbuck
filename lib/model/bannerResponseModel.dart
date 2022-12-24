// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
    required this.bannerImageName,
    required this.bannerImagePath,
  });

  String bannerImageName;
  String bannerImagePath;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bannerImageName: json["banner_image_name"],
        bannerImagePath: json["banner_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "banner_image_name": bannerImageName,
        "banner_image_path": bannerImagePath,
      };
}

// To parse this JSON data, do
//
//     final popularBrandsResponseModel = popularBrandsResponseModelFromJson(jsonString);

import 'dart:convert';

PopularBrandsResponseModel popularBrandsResponseModelFromJson(String str) =>
    PopularBrandsResponseModel.fromJson(json.decode(str));

String popularBrandsResponseModelToJson(PopularBrandsResponseModel data) =>
    json.encode(data.toJson());

class PopularBrandsResponseModel {
  PopularBrandsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory PopularBrandsResponseModel.fromJson(Map<String, dynamic> json) =>
      PopularBrandsResponseModel(
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
    required this.id,
    required this.name,
    required this.email,
    required this.brandName,
    required this.brandImagePath,
    required this.distance,
  });

  int id;
  String name;
  String email;
  String brandName;
  String brandImagePath;
  double distance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        brandName: json["brand_name"],
        brandImagePath: json["brand_image_path"],
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "brand_name": brandName,
        "brand_image_path": brandImagePath,
        "distance": distance,
      };
}

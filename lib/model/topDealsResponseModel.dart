// To parse this JSON data, do
//
//     final topDealsModel = topDealsModelFromJson(jsonString);

import 'dart:convert';

TopDealsModel topDealsModelFromJson(String str) =>
    TopDealsModel.fromJson(json.decode(str));

String topDealsModelToJson(TopDealsModel data) => json.encode(data.toJson());

class TopDealsModel {
  TopDealsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum>? data;

  factory TopDealsModel.fromJson(Map<String, dynamic> json) => TopDealsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.productName,
    required this.description,
    required this.featuredImagePath,
    required this.distance,
  });

  int? id;
  String? productName;
  String? description;
  String? featuredImagePath;
  double? distance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        featuredImagePath: json["featured_image_path"],
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "featured_image_path": featuredImagePath,
        "distance": distance,
      };
}

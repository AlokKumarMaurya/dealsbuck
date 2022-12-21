// To parse this JSON data, do
//
//     final particularCategoryList = particularCategoryListFromJson(jsonString);

import 'dart:convert';

ParticularCategoryList particularCategoryListFromJson(String str) => ParticularCategoryList.fromJson(json.decode(str));

String particularCategoryListToJson(ParticularCategoryList data) => json.encode(data.toJson());

class ParticularCategoryList {
  ParticularCategoryList({
  required this.status,
  required this.message,
  required this.data,
  });

  bool status;
  String message;
  Data data;

  factory ParticularCategoryList.fromJson(Map<String, dynamic> json) => ParticularCategoryList(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
   required this.id,
   required this.name,
   required this.vendors,
  });

  int id;
  String name;
  List<Vendor> vendors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    vendors: List<Vendor>.from(json["vendors"].map((x) => Vendor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "vendors": List<dynamic>.from(vendors.map((x) => x.toJson())),
  };
}

class Vendor {
  Vendor({
   required this.id,
   required this.brandName,
   required this.brandImagePath,
   required this.distance,
  });

  int id;
  String brandName;
  String brandImagePath;
  double distance;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    brandName: json["brand_name"],
    brandImagePath: json["brand_image_path"],
    distance: json["distance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "brand_image_path": brandImagePath,
    "distance": distance,
  };
}

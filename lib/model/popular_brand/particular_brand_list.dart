// To parse this JSON data, do
//
//     final particularBrandList = particularBrandListFromJson(jsonString);

import 'dart:convert';

ParticularBrandList particularBrandListFromJson(String str) =>
    ParticularBrandList.fromJson(json.decode(str));

String particularBrandListToJson(ParticularBrandList data) =>
    json.encode(data.toJson());

class ParticularBrandList {
  ParticularBrandList({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory ParticularBrandList.fromJson(Map<String, dynamic> json) =>
      ParticularBrandList(
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
    required this.brandName,
    required this.brandImagePath,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.latitude,
    required this.longitude,
    required this.products,
  });

  int id;
  String brandName;
  String brandImagePath;
  String city;
  String state;
  int pinCode;
  String latitude;
  String longitude;
  List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        brandName: json["brand_name"],
        brandImagePath: json["brand_image_path"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pin_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name": brandName,
        "brand_image_path": brandImagePath,
        "city": city,
        "state": state,
        "pin_code": pinCode,
        "latitude": latitude,
        "longitude": longitude,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.featuredImagePath,
  });

  int id;
  String productName;
  String featuredImagePath;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        featuredImagePath: json["featured_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "featured_image_path": featuredImagePath,
      };
}

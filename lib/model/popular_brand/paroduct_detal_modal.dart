// To parse this JSON data, do
//
//     final populareBrandParticularProductDeatil = populareBrandParticularProductDeatilFromJson(jsonString);

import 'dart:convert';

PopulareBrandParticularProductDeatil
    populareBrandParticularProductDeatilFromJson(String str) =>
        PopulareBrandParticularProductDeatil.fromJson(json.decode(str));

String populareBrandParticularProductDeatilToJson(
        PopulareBrandParticularProductDeatil data) =>
    json.encode(data.toJson());

class PopulareBrandParticularProductDeatil {
  PopulareBrandParticularProductDeatil({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory PopulareBrandParticularProductDeatil.fromJson(
          Map<String, dynamic> json) =>
      PopulareBrandParticularProductDeatil(
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
    required this.productName,
    required this.price,
    required this.description,
    required this.specification,
    required this.couponCode,
    required this.categoryName,
    required this.brandName,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.reviews,
    required this.avgRating,
  });

  int id;
  String productName;
  String price;
  String description;
  String specification;
  String couponCode;
  String categoryName;
  String brandName;
  String city;
  String state;
  int pinCode;
  String latitude;
  String longitude;
  List<ImageData> images;
  List<dynamic> reviews;
  dynamic avgRating;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        description: json["description"],
        specification: json["specification"],
        couponCode: json["coupon_code"],
        categoryName: json["category_name"],
        brandName: json["brand_name"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pin_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        images: List<ImageData>.from(
            json["images"].map((x) => ImageData.fromJson(x))),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        avgRating: json["avg-rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "description": description,
        "specification": specification,
        "coupon_code": couponCode,
        "category_name": categoryName,
        "brand_name": brandName,
        "city": city,
        "state": state,
        "pin_code": pinCode,
        "latitude": latitude,
        "longitude": longitude,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "avg-rating": avgRating,
      };
}

class ImageData {
  ImageData({
    required this.id,
    required this.productImageName,
    required this.productImagePath,
  });

  int id;
  String productImageName;
  String productImagePath;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        productImageName: json["product_image_name"],
        productImagePath: json["product_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_image_name": productImageName,
        "product_image_path": productImagePath,
      };
}

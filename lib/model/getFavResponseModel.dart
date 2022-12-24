// To parse this JSON data, do
//
//     final getFavModel = getFavModelFromJson(jsonString);

import 'dart:convert';

GetFavModel getFavModelFromJson(String str) =>
    GetFavModel.fromJson(json.decode(str));

String getFavModelToJson(GetFavModel data) => json.encode(data.toJson());

class GetFavModel {
  GetFavModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory GetFavModel.fromJson(Map<String, dynamic> json) => GetFavModel(
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
    required this.description,
    required this.specification,
    required this.featuredImageName,
    required this.featuredImageOriginal,
    required this.featuredImagePath,
    required this.price,
    required this.couponCode,
    required this.categoryId,
    required this.userId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String name;
  String description;
  String specification;
  String featuredImageName;
  String featuredImageOriginal;
  String featuredImagePath;
  String price;
  String couponCode;
  int categoryId;
  int userId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        specification: json["specification"],
        featuredImageName: json["featured_image_name"],
        featuredImageOriginal: json["featured_image_original"],
        featuredImagePath: json["featured_image_path"],
        price: json["price"],
        couponCode: json["coupon_code"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "specification": specification,
        "featured_image_name": featuredImageName,
        "featured_image_original": featuredImageOriginal,
        "featured_image_path": featuredImagePath,
        "price": price,
        "coupon_code": couponCode,
        "category_id": categoryId,
        "user_id": userId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.userId,
    required this.productId,
  });

  int userId;
  int productId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "product_id": productId,
      };
}

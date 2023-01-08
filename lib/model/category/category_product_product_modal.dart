// // To parse this JSON data, do
// //
// //     final categoryProductProductDeatilModal = categoryProductProductDeatilModalFromJson(jsonString);
//
// import 'dart:convert';
//
// CategoryProductProductDeatilModal categoryProductProductDeatilModalFromJson(
//         String str) =>
//     CategoryProductProductDeatilModal.fromJson(json.decode(str));
//
// String categoryProductProductDeatilModalToJson(
//         CategoryProductProductDeatilModal data) =>
//     json.encode(data.toJson());
//
// class CategoryProductProductDeatilModal {
//   CategoryProductProductDeatilModal({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   bool status;
//   String message;
//   Data data;
//
//   factory CategoryProductProductDeatilModal.fromJson(
//           Map<String, dynamic> json) =>
//       CategoryProductProductDeatilModal(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//       };
// }
//
// class Data {
//   Data({
//     required this.categoryId,
//     required this.categoryName,
//     required this.brandName,
//     required this.brandImagePath,
//     required this.city,
//     required this.state,
//     required this.pinCode,
//     required this.latitude,
//     required this.longitude,
//     required this.products,
//   });
//
//   int categoryId;
//   String categoryName;
//   String brandName;
//   String brandImagePath;
//   String city;
//   String state;
//   int pinCode;
//   String latitude;
//   String longitude;
//   List<Product> products;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         categoryId: json["category_id"],
//         categoryName: json["category_name"],
//         brandName: json["brand_name"],
//         brandImagePath: json["brand_image_path"],
//         city: json["city"],
//         state: json["state"],
//         pinCode: json["pin_code"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         products: List<Product>.from(
//             json["products"].map((x) => Product.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "category_id": categoryId,
//         "category_name": categoryName,
//         "brand_name": brandName,
//         "brand_image_path": brandImagePath,
//         "city": city,
//         "state": state,
//         "pin_code": pinCode,
//         "latitude": latitude,
//         "longitude": longitude,
//         "products": List<dynamic>.from(products.map((x) => x.toJson())),
//       };
// }
//
// class Product {
//   Product({
//     required this.id,
//     required this.productName,
//     required this.featuredImagePath,
//   });
//
//   int id;
//   String productName;
//   String featuredImagePath;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         productName: json["product_name"],
//         featuredImagePath: json["featured_image_path"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_name": productName,
//         "featured_image_path": featuredImagePath,
//       };
// }













// To parse this JSON data, do
//
//     final categoryProductProductDeatilModal = categoryProductProductDeatilModalFromJson(jsonString);

import 'dart:convert';

CategoryProductProductDeatilModal? categoryProductProductDeatilModalFromJson(String str) => CategoryProductProductDeatilModal.fromJson(json.decode(str));

String categoryProductProductDeatilModalToJson(CategoryProductProductDeatilModal? data) => json.encode(data!.toJson());

class CategoryProductProductDeatilModal {
  CategoryProductProductDeatilModal({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory CategoryProductProductDeatilModal.fromJson(Map<String, dynamic> json) => CategoryProductProductDeatilModal(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.categoryId,
    this.categoryName,
    this.brandName,
    this.brandImagePath,
    this.city,
    this.state,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.products,
  });

  int? categoryId;
  String? categoryName;
  String? brandName;
  String? brandImagePath;
  String? city;
  String? state;
  int? pinCode;
  String? latitude;
  String? longitude;
  List<Product?>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    brandName: json["brand_name"],
    brandImagePath: json["brand_image_path"],
    city: json["city"],
    state: json["state"],
    pinCode: json["pin_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    products: json["products"] == null ? [] : List<Product?>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "brand_name": brandName,
    "brand_image_path": brandImagePath,
    "city": city,
    "state": state,
    "pin_code": pinCode,
    "latitude": latitude,
    "longitude": longitude,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x!.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.productName,
    this.specification,
    this.description,
    this.featuredImageName,
    this.featuredImageOriginal,
    this.featuredImagePath,
    this.price,
    this.couponCode,
    this.categoryId,
    this.userId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? productName;
  String? specification;
  String? description;
  String? featuredImageName;
  String? featuredImageOriginal;
  String? featuredImagePath;
  String? price;
  String? couponCode;
  int? categoryId;
  int? userId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"],
    specification: json["specification"],
    description: json["description"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "specification": specification,
    "description": description,
    "featured_image_name": featuredImageName,
    "featured_image_original": featuredImageOriginal,
    "featured_image_path": featuredImagePath,
    "price": price,
    "coupon_code": couponCode,
    "category_id": categoryId,
    "user_id": userId,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

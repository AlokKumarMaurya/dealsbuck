// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromJson(jsonString);

import 'dart:convert';

SearchResponseModel searchResponseModelFromJson(String str) =>
    SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) =>
    json.encode(data.toJson());

class SearchResponseModel {
  SearchResponseModel({
    required this.status,
    required this.message,
    required this.input,
  });

  bool status;
  String message;
  Input input;

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchResponseModel(
        status: json["status"],
        message: json["message"],
        input: Input.fromJson(json["input"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "input": input.toJson(),
      };
}

class Input {
  Input({
    required this.categories,
    required this.products,
    required this.brands,
  });

  List<Category> categories;
  List<Product> products;
  List<Brand> brands;

  factory Input.fromJson(Map<String, dynamic> json) => Input(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
      };
}

class Brand {
  Brand({
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
  int distance;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        brandName: json["brand_name"],
        brandImagePath: json["brand_image_path"],
        distance: json["distance"],
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

class Category {
  Category({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.brandName,
    required this.distance,
  });

  int id;
  String name;
  String imagePath;
  String brandName;
  int distance;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        imagePath: json["image_path"],
        brandName: json["brand_name"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_path": imagePath,
        "brand_name": brandName,
        "distance": distance,
      };
}

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.description,
    required this.specification,
    required this.featuredImagePath,
    required this.distance,
  });

  int id;
  String productName;
  String description;
  String specification;
  String featuredImagePath;
  int distance;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        specification: json["specification"],
        featuredImagePath: json["featured_image_path"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "specification": specification,
        "featured_image_path": featuredImagePath,
        "distance": distance,
      };
}

// To parse this JSON data, do
//
//     final purchaseMembershipModel = purchaseMembershipModelFromJson(jsonString);

import 'dart:convert';

PurchaseMembershipModel purchaseMembershipModelFromJson(String str) => PurchaseMembershipModel.fromJson(json.decode(str));

String purchaseMembershipModelToJson(PurchaseMembershipModel data) => json.encode(data.toJson());

class PurchaseMembershipModel {
  PurchaseMembershipModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory PurchaseMembershipModel.fromJson(Map<String, dynamic> json) => PurchaseMembershipModel(
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
    required this.plan,
    required this.regularPrice,
    required this.price,
  });

  int id;
  String name;
  String plan;
  String regularPrice;
  String price;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    plan: json["plan"],
    regularPrice: json["regular_price"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "plan": plan,
    "regular_price": regularPrice,
    "price": price,
  };
}

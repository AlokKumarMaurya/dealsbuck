// To parse this JSON data, do
//
//     final membershipModel = membershipModelFromJson(jsonString);

import 'dart:convert';

MembershipModel membershipModelFromJson(String str) =>
    MembershipModel.fromJson(json.decode(str));

String membershipModelToJson(MembershipModel data) =>
    json.encode(data.toJson());

class MembershipModel {
  MembershipModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      MembershipModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.username,
    required this.email,
    this.packageId,
    this.packageExpiry,
    this.packagename,
    this.plan,
    this.regularPrice,
    this.price,
  });

  int id;
  String username;
  String email;
  dynamic packageId;
  dynamic packageExpiry;
  dynamic packagename;
  dynamic plan;
  dynamic regularPrice;
  dynamic price;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        packageId: json["package_id"],
        packageExpiry: json["package_expiry"],
        packagename: json["packagename"],
        plan: json["plan"],
        regularPrice: json["regular_price"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "package_id": packageId,
        "package_expiry": packageExpiry,
        "packagename": packagename,
        "plan": plan,
        "regular_price": regularPrice,
        "price": price,
      };
}

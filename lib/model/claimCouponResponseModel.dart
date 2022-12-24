// To parse this JSON data, do
//
//     final claimCouponModel = claimCouponModelFromJson(jsonString);

import 'dart:convert';

ClaimCouponModel claimCouponModelFromJson(String str) =>
    ClaimCouponModel.fromJson(json.decode(str));

String claimCouponModelToJson(ClaimCouponModel data) =>
    json.encode(data.toJson());

class ClaimCouponModel {
  bool status;

  ClaimCouponModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory ClaimCouponModel.fromJson(Map<String, dynamic> json) =>
      ClaimCouponModel(
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
    required this.vendorId,
    required this.couponCode,
    required this.vendorName,
    required this.vendorEmail,
  });

  int id;
  int vendorId;
  String couponCode;
  String vendorName;
  String vendorEmail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        vendorId: json["vendor_id"],
        couponCode: json["coupon_code"],
        vendorName: json["vendor_name"],
        vendorEmail: json["vendor_email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "coupon_code": couponCode,
        "vendor_name": vendorName,
        "vendor_email": vendorEmail,
      };
}

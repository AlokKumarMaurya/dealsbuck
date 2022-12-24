// To parse this JSON data, do
//
//     final showCouponModel = showCouponModelFromJson(jsonString);

import 'dart:convert';

ShowCouponModel showCouponModelFromJson(String str) =>
    ShowCouponModel.fromJson(json.decode(str));

String showCouponModelToJson(ShowCouponModel data) =>
    json.encode(data.toJson());

class ShowCouponModel {
  ShowCouponModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ShowCouponModel.fromJson(Map<String, dynamic> json) =>
      ShowCouponModel(
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
    required this.productId,
    required this.couponCode,
    required this.vendorId,
    required this.vendorName,
  });

  int id;
  int productId;
  String couponCode;
  int vendorId;
  String vendorName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        couponCode: json["coupon_code"],
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "coupon_code": couponCode,
        "vendor_id": vendorId,
        "vendor_name": vendorName,
      };
}

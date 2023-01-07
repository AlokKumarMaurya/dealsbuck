// To parse this JSON data, do
//
//     final getUserPersonalDetailModal = getUserPersonalDetailModalFromJson(jsonString);

import 'dart:convert';

GetUserPersonalDetailModal? getUserPersonalDetailModalFromJson(String str) => GetUserPersonalDetailModal.fromJson(json.decode(str));

String getUserPersonalDetailModalToJson(GetUserPersonalDetailModal? data) => json.encode(data!.toJson());

class GetUserPersonalDetailModal {
  GetUserPersonalDetailModal({
    this.status,
    this.user,
  });

  bool? status;
  User? user;

  factory GetUserPersonalDetailModal.fromJson(Map<String, dynamic> json) => GetUserPersonalDetailModal(
    status: json["status"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.mobileNo,
    this.email,
    this.emailVerifiedAt,
    this.otp,
    this.dob,
    this.isAdmin,
    this.packageId,
    this.packageExpiry,
    this.brandName,
    this.brandImageName,
    this.brandOriginalImage,
    this.brandImagePath,
    this.city,
    this.state,
    this.pinCode,
    this.fullAddress,
    this.latitude,
    this.longitude,
    this.popular,
    this.deviceToken,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? mobileNo;
  String? email;
  DateTime? emailVerifiedAt;
  dynamic otp;
  DateTime? dob;
  int? isAdmin;
  int? packageId;
  DateTime? packageExpiry;
  String? brandName;
  String? brandImageName;
  String? brandOriginalImage;
  String? brandImagePath;
  String? city;
  String? state;
  int? pinCode;
  String? fullAddress;
  String? latitude;
  String? longitude;
  dynamic popular;
  dynamic deviceToken;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    mobileNo: json["mobile_no"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    otp: json["otp"],
    dob: DateTime.parse(json["dob"]),
    isAdmin: json["is_admin"],
    packageId: json["package_id"],
    packageExpiry: DateTime.parse(json["package_expiry"]),
    brandName: json["brand_name"],
    brandImageName: json["brand_image_name"],
    brandOriginalImage: json["brand_original_image"],
    brandImagePath: json["brand_image_path"],
    city: json["city"],
    state: json["state"],
    pinCode: json["pin_code"],
    fullAddress: json["full_address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    popular: json["popular"],
    deviceToken: json["device_token"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile_no": mobileNo,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "otp": otp,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "is_admin": isAdmin,
    "package_id": packageId,
    "package_expiry": "${packageExpiry!.year.toString().padLeft(4, '0')}-${packageExpiry!.month.toString().padLeft(2, '0')}-${packageExpiry!.day.toString().padLeft(2, '0')}",
    "brand_name": brandName,
    "brand_image_name": brandImageName,
    "brand_original_image": brandOriginalImage,
    "brand_image_path": brandImagePath,
    "city": city,
    "state": state,
    "pin_code": pinCode,
    "full_address": fullAddress,
    "latitude": latitude,
    "longitude": longitude,
    "popular": popular,
    "device_token": deviceToken,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

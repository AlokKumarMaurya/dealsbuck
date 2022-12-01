// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    required this.status,
    required this.message,
    required this.token,
    required this.name,
  });

  bool status;
  String message;
  String token;
  String name;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    token: json["token"] == null ? null : json["token"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "token": token == null ? null : token,
    "name": name == null ? null : name,
  };
}

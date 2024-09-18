// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodModel paymentMethodModelFromJson(String str) =>
    PaymentMethodModel.fromJson(json.decode(str));

String paymentMethodModelToJson(PaymentMethodModel data) =>
    json.encode(data.toJson());

class PaymentMethodModel {
  String? id;
  String? programId;
  String? name;
  String? description;
  String? type;
  String? imgUrl;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentMethodModel({
    this.id,
    this.programId,
    this.name,
    this.description,
    this.type,
    this.imgUrl,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json["id"],
        programId: json["program_id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        imgUrl: json["img_url"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => id == null
      ? {
          "program_id": programId,
          "name": name,
          "description": description,
          "type": type,
          "img_url": imgUrl,
        }
      : {
          "id": id,
          "program_id": programId,
          "name": name,
          "description": description,
          "type": type,
          "img_url": imgUrl,
        };
}

// To parse this JSON data, do
//
//     final programPaymentModel = programPaymentModelFromJson(jsonString);

import 'dart:convert';

ProgramPaymentModel programPaymentModelFromJson(String str) =>
    ProgramPaymentModel.fromJson(json.decode(str));

String programPaymentModelToJson(ProgramPaymentModel data) =>
    json.encode(data.toJson());

class ProgramPaymentModel {
  String? id;
  String? programId;
  String? name;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? orderNumber;
  String? idrAmount;
  String? usdAmount;
  String? category;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProgramPaymentModel({
    this.id,
    this.programId,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.orderNumber,
    this.idrAmount,
    this.usdAmount,
    this.category,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramPaymentModel.fromJson(Map<String, dynamic> json) =>
      ProgramPaymentModel(
        id: json["id"],
        programId: json["program_id"],
        name: json["name"],
        description: json["description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        orderNumber: json["order_number"],
        idrAmount: json["idr_amount"],
        usdAmount: json["usd_amount"],
        category: json["category"],
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
          "start_date": startDate?.toIso8601String(),
          "end_date": endDate?.toIso8601String(),
          "order_number": orderNumber,
          "idr_amount": idrAmount,
          "usd_amount": usdAmount,
          "category": category,
        }
      : {
          "id": id,
          "program_id": programId,
          "name": name,
          "description": description,
          "start_date": startDate?.toIso8601String(),
          "end_date": endDate?.toIso8601String(),
          "order_number": orderNumber,
          "idr_amount": idrAmount,
          "usd_amount": usdAmount,
          "category": category,
        };
}

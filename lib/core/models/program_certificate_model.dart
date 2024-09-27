// To parse this JSON data, do
//
//     final programCertificateModel = programCertificateModelFromJson(jsonString);

import 'dart:convert';

ProgramCertificateModel programCertificateModelFromJson(String str) =>
    ProgramCertificateModel.fromJson(json.decode(str));

String programCertificateModelToJson(ProgramCertificateModel data) =>
    json.encode(data.toJson());

class ProgramCertificateModel {
  String? id;
  String? programId;
  String? templateUrl;
  String? title;
  String? description;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProgramCertificateModel({
    this.id,
    this.programId,
    this.templateUrl,
    this.title,
    this.description,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramCertificateModel.fromJson(Map<String, dynamic> json) =>
      ProgramCertificateModel(
        id: json["id"],
        programId: json["program_id"],
        templateUrl: json["template_url"],
        title: json["title"],
        description: json["description"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "program_id": programId,
        "template_url": templateUrl,
        "title": title,
        "description": description,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

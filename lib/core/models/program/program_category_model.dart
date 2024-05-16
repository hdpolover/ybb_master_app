// To parse this JSON data, do
//
//     final programCategoryModel = programCategoryModelFromJson(jsonString);

import 'dart:convert';

ProgramCategoryModel programCategoryModelFromJson(String str) =>
    ProgramCategoryModel.fromJson(json.decode(str));

String programCategoryModelToJson(ProgramCategoryModel data) =>
    json.encode(data.toJson());

class ProgramCategoryModel {
  String? id;
  String? name;
  String? description;
  String? programTypeId;
  String? webUrl;
  String? contact;
  String? location;
  String? email;
  String? instagram;
  String? tiktok;
  String? youtube;
  String? telegram;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProgramCategoryModel({
    this.id,
    this.name,
    this.description,
    this.programTypeId,
    this.webUrl,
    this.contact,
    this.location,
    this.email,
    this.instagram,
    this.tiktok,
    this.youtube,
    this.telegram,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProgramCategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        programTypeId: json["program_type_id"],
        webUrl: json["web_url"],
        contact: json["contact"],
        location: json["location"],
        email: json["email"],
        instagram: json["instagram"],
        tiktok: json["tiktok"],
        youtube: json["youtube"],
        telegram: json["telegram"],
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
        "name": name,
        "description": description,
        "program_type_id": programTypeId,
        "web_url": webUrl,
        "contact": contact,
        "location": location,
        "email": email,
        "instagram": instagram,
        "tiktok": tiktok,
        "youtube": youtube,
        "telegram": telegram,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

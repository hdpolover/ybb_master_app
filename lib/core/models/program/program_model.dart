// To parse this JSON data, do
//
//     final programModel = programModelFromJson(jsonString);

import 'dart:convert';

ProgramModel programModelFromJson(String str) =>
    ProgramModel.fromJson(json.decode(str));

String programModelToJson(ProgramModel data) => json.encode(data.toJson());

class ProgramModel {
  String? id;
  String? programCategoryId;
  String? name;
  String? logoUrl;
  String? description;
  String? guideline;
  String? twibbon;
  DateTime? startDate;
  DateTime? endDate;
  String? registrationVideoUrl;
  String? sponsorCanvaUrl;
  dynamic theme;
  dynamic subThemes;
  String? shareDesc;
  dynamic confirmationDesc;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProgramModel({
    this.id,
    this.programCategoryId,
    this.name,
    this.logoUrl,
    this.description,
    this.guideline,
    this.twibbon,
    this.startDate,
    this.endDate,
    this.registrationVideoUrl,
    this.sponsorCanvaUrl,
    this.theme,
    this.subThemes,
    this.shareDesc,
    this.confirmationDesc,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json["id"],
        programCategoryId: json["program_category_id"],
        name: json["name"],
        logoUrl: json["logo_url"],
        description: json["description"],
        guideline: json["guideline"],
        twibbon: json["twibbon"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        registrationVideoUrl: json["registration_video_url"],
        sponsorCanvaUrl: json["sponsor_canva_url"],
        theme: json["theme"],
        subThemes: json["sub_themes"],
        shareDesc: json["share_desc"],
        confirmationDesc: json["confirmation_desc"],
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
        "program_category_id": programCategoryId,
        "name": name,
        "logo_url": logoUrl,
        "description": description,
        "guideline": guideline,
        "twibbon": twibbon,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "registration_video_url": registrationVideoUrl,
        "sponsor_canva_url": sponsorCanvaUrl,
        "theme": theme,
        "sub_themes": subThemes,
        "share_desc": shareDesc,
        "confirmation_desc": confirmationDesc,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

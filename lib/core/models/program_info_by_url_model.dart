// To parse this JSON data, do
//
//     final programInfoByUrlModel = programInfoByUrlModelFromJson(jsonString);

import 'dart:convert';

ProgramInfoByUrlModel programInfoByUrlModelFromJson(String str) =>
    ProgramInfoByUrlModel.fromJson(json.decode(str));

String programInfoByUrlModelToJson(ProgramInfoByUrlModel data) =>
    json.encode(data.toJson());

class ProgramInfoByUrlModel {
  String? id;
  String? name;
  String? description;
  String? programTypeId;
  String? webUrl;
  String? logoUrl;
  String? tagline;
  String? contact;
  String? location;
  String? email;
  String? instagram;
  String? tiktok;
  String? youtube;
  String? telegram;
  String? verificationRequired;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? programCategoryId;
  String? guideline;
  String? twibbon;
  DateTime? startDate;
  DateTime? endDate;
  String? registrationVideoUrl;
  String? sponsorCanvaUrl;
  String? theme;
  dynamic subThemes;
  String? shareDesc;
  String? confirmationDesc;

  ProgramInfoByUrlModel({
    this.id,
    this.name,
    this.description,
    this.programTypeId,
    this.webUrl,
    this.logoUrl,
    this.tagline,
    this.contact,
    this.location,
    this.email,
    this.instagram,
    this.tiktok,
    this.youtube,
    this.telegram,
    this.verificationRequired,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.programCategoryId,
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
  });

  factory ProgramInfoByUrlModel.fromJson(Map<String, dynamic> json) =>
      ProgramInfoByUrlModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        programTypeId: json["program_type_id"],
        webUrl: json["web_url"],
        logoUrl: json["logo_url"],
        tagline: json["tagline"],
        contact: json["contact"],
        location: json["location"],
        email: json["email"],
        instagram: json["instagram"],
        tiktok: json["tiktok"],
        youtube: json["youtube"],
        telegram: json["telegram"],
        verificationRequired: json["verification_required"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        programCategoryId: json["program_category_id"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "program_type_id": programTypeId,
        "web_url": webUrl,
        "logo_url": logoUrl,
        "tagline": tagline,
        "contact": contact,
        "location": location,
        "email": email,
        "instagram": instagram,
        "tiktok": tiktok,
        "youtube": youtube,
        "telegram": telegram,
        "verification_required": verificationRequired,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "program_category_id": programCategoryId,
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
      };
}

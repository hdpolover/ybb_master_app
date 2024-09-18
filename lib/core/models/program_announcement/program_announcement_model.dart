// To parse this JSON data, do
//
//     final programAnnouncementModel = programAnnouncementModelFromJson(jsonString);

import 'dart:convert';

ProgramAnnouncementModel programAnnouncementModelFromJson(String str) =>
    ProgramAnnouncementModel.fromJson(json.decode(str));

String programAnnouncementModelToJson(ProgramAnnouncementModel data) =>
    json.encode(data.toJson());

class ProgramAnnouncementModel {
  String? id;
  String? programId;
  String? title;
  String? description;
  dynamic imgUrl;
  String? visibleTo;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProgramAnnouncementModel({
    this.id,
    this.programId,
    this.title,
    this.description,
    this.imgUrl,
    this.visibleTo,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramAnnouncementModel.fromJson(Map<String, dynamic> json) =>
      ProgramAnnouncementModel(
        id: json["id"],
        programId: json["program_id"],
        title: json["title"],
        description: json["description"],
        imgUrl: json["img_url"],
        visibleTo: json["visible_to"],
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
        "title": title,
        "description": description,
        "img_url": imgUrl,
        "visible_to": visibleTo,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

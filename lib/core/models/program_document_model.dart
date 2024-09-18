// To parse this JSON data, do
//
//     final programDocumentModel = programDocumentModelFromJson(jsonString);

import 'dart:convert';

ProgramDocumentModel programDocumentModelFromJson(String str) =>
    ProgramDocumentModel.fromJson(json.decode(str));

String programDocumentModelToJson(ProgramDocumentModel data) =>
    json.encode(data.toJson());

class ProgramDocumentModel {
  String? id;
  String? programId;
  String? name;
  dynamic fileUrl;
  String? driveUrl;
  String? desc;
  String? isUpload;
  String? isGenerated;
  String? visibility;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProgramDocumentModel({
    this.id,
    this.programId,
    this.name,
    this.fileUrl,
    this.driveUrl,
    this.desc,
    this.isUpload,
    this.isGenerated,
    this.visibility,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramDocumentModel.fromJson(Map<String, dynamic> json) =>
      ProgramDocumentModel(
        id: json["id"],
        programId: json["program_id"],
        name: json["name"],
        fileUrl: json["file_url"],
        driveUrl: json["drive_url"],
        desc: json["desc"],
        isUpload: json["is_upload"],
        isGenerated: json["is_generated"],
        visibility: json["visibility"],
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
        "name": name,
        "file_url": fileUrl,
        "drive_url": driveUrl,
        "desc": desc,
        "is_upload": isUpload,
        "is_generated": isGenerated,
        "visibility": visibility,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

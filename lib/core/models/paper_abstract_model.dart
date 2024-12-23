// To parse this JSON data, do
//
//     final paperAbstractModel = paperAbstractModelFromJson(jsonString);

import 'dart:convert';

PaperAbstractModel paperAbstractModelFromJson(String str) =>
    PaperAbstractModel.fromJson(json.decode(str));

String paperAbstractModelToJson(PaperAbstractModel data) =>
    json.encode(data.toJson());

class PaperAbstractModel {
  String? id;
  String? title;
  String? content;
  String? keywords;
  String? status;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaperAbstractModel({
    this.id,
    this.title,
    this.content,
    this.keywords,
    this.status,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PaperAbstractModel.fromJson(Map<String, dynamic> json) =>
      PaperAbstractModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        keywords: json["keywords"],
        status: json["status"],
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
        "title": title,
        "content": content,
        "keywords": keywords,
        "status": status,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

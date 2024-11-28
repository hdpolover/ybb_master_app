// To parse this JSON data, do
//
//     final paperReviewerModel = paperReviewerModelFromJson(jsonString);

import 'dart:convert';

PaperReviewerModel paperReviewerModelFromJson(String str) =>
    PaperReviewerModel.fromJson(json.decode(str));

String paperReviewerModelToJson(PaperReviewerModel data) =>
    json.encode(data.toJson());

class PaperReviewerModel {
  String? id;
  String? paperTopicId;
  String? programId;
  String? name;
  String? email;
  String? institution;
  String? password;
  String? topicAccess;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaperReviewerModel({
    this.id,
    this.paperTopicId,
    this.programId,
    this.name,
    this.email,
    this.institution,
    this.password,
    this.topicAccess,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PaperReviewerModel.fromJson(Map<String, dynamic> json) =>
      PaperReviewerModel(
        id: json["id"],
        paperTopicId: json["paper_topic_id"],
        programId: json["program_id"],
        name: json["name"],
        email: json["email"],
        institution: json["institution"],
        password: json["password"],
        topicAccess: json["topic_access"],
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
        "paper_topic_id": paperTopicId,
        "program_id": programId,
        "name": name,
        "email": email,
        "institution": institution,
        "password": password,
        "topic_access": topicAccess,
      };
}

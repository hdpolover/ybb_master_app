// To parse this JSON data, do
//
//     final paperTopicModel = paperTopicModelFromJson(jsonString);

import 'dart:convert';

PaperTopicModel paperTopicModelFromJson(String str) =>
    PaperTopicModel.fromJson(json.decode(str));

String paperTopicModelToJson(PaperTopicModel data) =>
    json.encode(data.toJson());

class PaperTopicModel {
  String? id;
  String? programId;
  String? topicName;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaperTopicModel({
    this.id,
    this.programId,
    this.topicName,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PaperTopicModel.fromJson(Map<String, dynamic> json) =>
      PaperTopicModel(
        id: json["id"],
        programId: json["program_id"],
        topicName: json["topic_name"],
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
        "program_id": programId,
        "topic_name": topicName,
      };
}

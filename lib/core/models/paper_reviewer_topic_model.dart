// To parse this JSON data, do
//
//     final paperReviewerTopicModel = paperReviewerTopicModelFromJson(jsonString);

import 'dart:convert';

PaperReviewerTopicModel paperReviewerTopicModelFromJson(String str) =>
    PaperReviewerTopicModel.fromJson(json.decode(str));

String paperReviewerTopicModelToJson(PaperReviewerTopicModel data) =>
    json.encode(data.toJson());

class PaperReviewerTopicModel {
  String? id;
  String? paperReviewerId;
  String? paperTopicId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? isActive;
  String? isDeleted;

  PaperReviewerTopicModel({
    this.id,
    this.paperReviewerId,
    this.paperTopicId,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.isDeleted,
  });

  factory PaperReviewerTopicModel.fromJson(Map<String, dynamic> json) =>
      PaperReviewerTopicModel(
        id: json["id"],
        paperReviewerId: json["paper_reviewer_id"],
        paperTopicId: json["paper_topic_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "paper_reviewer_id": paperReviewerId,
        "paper_topic_id": paperTopicId,
      };
}

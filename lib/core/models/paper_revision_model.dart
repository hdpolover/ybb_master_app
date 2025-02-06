// To parse this JSON data, do
//
//     final paperRevisionModel = paperRevisionModelFromJson(jsonString);

import 'dart:convert';

PaperRevisionModel paperRevisionModelFromJson(String str) =>
    PaperRevisionModel.fromJson(json.decode(str));

String paperRevisionModelToJson(PaperRevisionModel data) =>
    json.encode(data.toJson());

class PaperRevisionModel {
  String? id;
  String? paperDetailId;
  String? paperReviewerId;
  String? comment;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaperRevisionModel({
    this.id,
    this.paperDetailId,
    this.paperReviewerId,
    this.comment,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PaperRevisionModel.fromJson(Map<String, dynamic> json) =>
      PaperRevisionModel(
        id: json["id"],
        paperDetailId: json["paper_detail_id"],
        paperReviewerId: json["paper_reviewer_id"],
        comment: json["comment"],
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
        "paper_detail_id": paperDetailId,
        "paper_reviewer_id": paperReviewerId,
        "comment": comment,
      };
}

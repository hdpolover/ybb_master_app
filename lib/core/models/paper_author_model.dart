// To parse this JSON data, do
//
//     final paperAuthorModel = paperAuthorModelFromJson(jsonString);

import 'dart:convert';

PaperAuthorModel paperAuthorModelFromJson(String str) =>
    PaperAuthorModel.fromJson(json.decode(str));

String paperAuthorModelToJson(PaperAuthorModel data) =>
    json.encode(data.toJson());

class PaperAuthorModel {
  String? id;
  String? participantId;
  dynamic paperDetailId;
  String? name;
  String? institution;
  String? email;
  String? isParticipant;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaperAuthorModel({
    this.id,
    this.participantId,
    this.paperDetailId,
    this.name,
    this.institution,
    this.email,
    this.isParticipant,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PaperAuthorModel.fromJson(Map<String, dynamic> json) =>
      PaperAuthorModel(
        id: json["id"],
        participantId: json["participant_id"],
        paperDetailId: json["paper_detail_id"],
        name: json["name"],
        institution: json["institution"],
        email: json["email"],
        isParticipant: json["is_participant"],
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
        "participant_id": participantId,
        "paper_detail_id": paperDetailId,
        "name": name,
        "institution": institution,
        "email": email,
        "is_participant": isParticipant,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

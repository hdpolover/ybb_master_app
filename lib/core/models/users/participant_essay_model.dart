// To parse this JSON data, do
//
//     final participantEssayModel = participantEssayModelFromJson(jsonString);

import 'dart:convert';

ParticipantEssayModel participantEssayModelFromJson(String str) =>
    ParticipantEssayModel.fromJson(json.decode(str));

String participantEssayModelToJson(ParticipantEssayModel data) =>
    json.encode(data.toJson());

class ParticipantEssayModel {
  String? id;
  String? participantId;
  String? programEssayId;
  String? answer;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? questions;

  ParticipantEssayModel({
    this.id,
    this.participantId,
    this.programEssayId,
    this.answer,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.questions,
  });

  factory ParticipantEssayModel.fromJson(Map<String, dynamic> json) =>
      ParticipantEssayModel(
        id: json["id"],
        participantId: json["participant_id"],
        programEssayId: json["program_essay_id"],
        answer: json["answer"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        questions: json["questions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "participant_id": participantId,
        "program_essay_id": programEssayId,
        "answer": answer,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions": questions,
      };
}

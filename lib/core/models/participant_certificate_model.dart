// To parse this JSON data, do
//
//     final participantCertificateModel = participantCertificateModelFromJson(jsonString);

import 'dart:convert';

ParticipantCertificateModel participantCertificateModelFromJson(String str) =>
    ParticipantCertificateModel.fromJson(json.decode(str));

String participantCertificateModelToJson(ParticipantCertificateModel data) =>
    json.encode(data.toJson());

class ParticipantCertificateModel {
  String? id;
  String? participantId;
  String? programCertificateId;
  dynamic validUntil;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ParticipantCertificateModel({
    this.id,
    this.participantId,
    this.programCertificateId,
    this.validUntil,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ParticipantCertificateModel.fromJson(Map<String, dynamic> json) =>
      ParticipantCertificateModel(
        id: json["id"],
        participantId: json["participant_id"],
        programCertificateId: json["program_certificate_id"],
        validUntil: json["valid_until"],
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
        "program_certificate_id": programCertificateId,
        "valid_until": validUntil,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

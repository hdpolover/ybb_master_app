// To parse this JSON data, do
//
//     final participantStatusModel = participantStatusModelFromJson(jsonString);

import 'dart:convert';

ParticipantStatusModel participantStatusModelFromJson(String str) =>
    ParticipantStatusModel.fromJson(json.decode(str));

String participantStatusModelToJson(ParticipantStatusModel data) =>
    json.encode(data.toJson());

class ParticipantStatusModel {
  String? id;
  String? participantId;
  String? generalStatus;
  String? formStatus;
  String? documentStatus;
  String? paymentStatus;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ParticipantStatusModel({
    this.id,
    this.participantId,
    this.generalStatus,
    this.formStatus,
    this.documentStatus,
    this.paymentStatus,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ParticipantStatusModel.fromJson(Map<String, dynamic> json) =>
      ParticipantStatusModel(
        id: json["id"],
        participantId: json["participant_id"],
        generalStatus: json["general_status"],
        formStatus: json["form_status"],
        documentStatus: json["document_status"],
        paymentStatus: json["payment_status"],
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
        "general_status": generalStatus,
        "form_status": formStatus,
        "document_status": documentStatus,
        "payment_status": paymentStatus,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

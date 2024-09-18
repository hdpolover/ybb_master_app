// To parse this JSON data, do
//
//     final participantModel = participantModelFromJson(jsonString);

import 'dart:convert';

ParticipantModel participantModelFromJson(String str) =>
    ParticipantModel.fromJson(json.decode(str));

String participantModelToJson(ParticipantModel data) =>
    json.encode(data.toJson());

class ParticipantModel {
  String? id;
  String? userId;
  String? accountId;
  String? fullName;
  DateTime? birthdate;
  String? refCodeAmbassador;
  String? programId;
  String? gender;
  String? originAddress;
  String? currentAddress;
  String? nationality;
  String? occupation;
  String? institution;
  String? organizations;
  String? countryCode;
  String? phoneNumber;
  String? pictureUrl;
  String? instagramAccount;
  String? emergencyAccount;
  String? contactRelation;
  String? diseaseHistory;
  String? tshirtSize;
  String? category;
  String? experiences;
  String? achievements;
  String? resumeUrl;
  String? knowledgeSource;
  String? sourceAccountName;
  String? twibbonLink;
  String? requirementLink;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? generalStatus;
  String? formStatus;
  String? documentStatus;
  String? paymentStatus;
  String? email;

  ParticipantModel({
    this.id,
    this.userId,
    this.accountId,
    this.fullName,
    this.birthdate,
    this.refCodeAmbassador,
    this.programId,
    this.gender,
    this.originAddress,
    this.currentAddress,
    this.nationality,
    this.occupation,
    this.institution,
    this.organizations,
    this.countryCode,
    this.phoneNumber,
    this.pictureUrl,
    this.instagramAccount,
    this.emergencyAccount,
    this.contactRelation,
    this.diseaseHistory,
    this.tshirtSize,
    this.category,
    this.experiences,
    this.achievements,
    this.resumeUrl,
    this.knowledgeSource,
    this.sourceAccountName,
    this.twibbonLink,
    this.requirementLink,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.generalStatus,
    this.formStatus,
    this.documentStatus,
    this.paymentStatus,
    this.email,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      ParticipantModel(
        id: json["id"],
        userId: json["user_id"],
        accountId: json["account_id"],
        fullName: json["full_name"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        refCodeAmbassador: json["ref_code_ambassador"],
        programId: json["program_id"],
        gender: json["gender"],
        originAddress: json["origin_address"],
        currentAddress: json["current_address"],
        nationality: json["nationality"],
        occupation: json["occupation"],
        institution: json["institution"],
        organizations: json["organizations"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        pictureUrl: json["picture_url"],
        instagramAccount: json["instagram_account"],
        emergencyAccount: json["emergency_account"],
        contactRelation: json["contact_relation"],
        diseaseHistory: json["disease_history"],
        tshirtSize: json["tshirt_size"],
        category: json["category"],
        experiences: json["experiences"],
        achievements: json["achievements"],
        resumeUrl: json["resume_url"],
        knowledgeSource: json["knowledge_source"],
        sourceAccountName: json["source_account_name"],
        twibbonLink: json["twibbon_link"],
        requirementLink: json["requirement_link"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        generalStatus: json["general_status"],
        formStatus: json["form_status"],
        documentStatus: json["document_status"],
        paymentStatus: json["payment_status"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "account_id": accountId,
        "full_name": fullName,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "ref_code_ambassador": refCodeAmbassador,
        "program_id": programId,
        "gender": gender,
        "origin_address": originAddress,
        "current_address": currentAddress,
        "nationality": nationality,
        "occupation": occupation,
        "institution": institution,
        "organizations": organizations,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "picture_url": pictureUrl,
        "instagram_account": instagramAccount,
        "emergency_account": emergencyAccount,
        "contact_relation": contactRelation,
        "disease_history": diseaseHistory,
        "tshirt_size": tshirtSize,
        "category": category,
        "experiences": experiences,
        "achievements": achievements,
        "resume_url": resumeUrl,
        "knowledge_source": knowledgeSource,
        "source_account_name": sourceAccountName,
        "twibbon_link": twibbonLink,
        "requirement_link": requirementLink,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "general_status": generalStatus,
        "form_status": formStatus,
        "document_status": documentStatus,
        "payment_status": paymentStatus,
        "email": email,
      };
}

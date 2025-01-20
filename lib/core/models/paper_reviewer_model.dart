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
  String? programId;
  String? name;
  String? email;
  String? institution;
  String? password;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaperReviewerModel({
    this.id,
    this.programId,
    this.name,
    this.email,
    this.institution,
    this.password,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  // to string
  @override
  String toString() {
    return 'PaperReviewerModel{id: $id, programId: $programId, name: $name, email: $email, institution: $institution, password: $password, isActive: $isActive, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  factory PaperReviewerModel.fromJson(Map<String, dynamic> json) =>
      PaperReviewerModel(
        id: json["id"],
        programId: json["program_id"],
        name: json["name"],
        email: json["email"],
        institution: json["institution"],
        password: json["password"],
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
        "name": name,
        "email": email,
        "institution": institution,
        "password": password,
      };
}

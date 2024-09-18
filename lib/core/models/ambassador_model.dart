// To parse this JSON data, do
//
//     final ambassadorModel = ambassadorModelFromJson(jsonString);

import 'dart:convert';

AmbassadorModel ambassadorModelFromJson(String str) =>
    AmbassadorModel.fromJson(json.decode(str));

String ambassadorModelToJson(AmbassadorModel data) =>
    json.encode(data.toJson());

class AmbassadorModel {
  String? id;
  String? name;
  String? email;
  String? refCode;
  String? programId;
  String? institution;
  String? gender;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  AmbassadorModel({
    this.id,
    this.name,
    this.email,
    this.refCode,
    this.programId,
    this.institution,
    this.gender,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory AmbassadorModel.fromJson(Map<String, dynamic> json) =>
      AmbassadorModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        refCode: json["ref_code"],
        programId: json["program_id"],
        institution: json["institution"],
        gender: json["gender"],
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
        "name": name,
        "email": email,
        "ref_code": refCode,
        "program_id": programId,
        "institution": institution,
        "gender": gender,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

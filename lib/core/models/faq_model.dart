// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  String? id;
  String? programId;
  String? question;
  String? answer;
  String? faqCategory;
  String? isActive;
  String? isDeleted;
  dynamic createdAt;
  dynamic updatedAt;

  FaqModel({
    this.id,
    this.programId,
    this.question,
    this.answer,
    this.faqCategory,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        programId: json["program_id"],
        question: json["question"],
        answer: json["answer"],
        faqCategory: json["faq_category"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "program_id": programId,
        "question": question,
        "answer": answer,
        "faq_category": faqCategory,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

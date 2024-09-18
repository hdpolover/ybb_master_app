// To parse this JSON data, do
//
//     final paymentXenditModel = paymentXenditModelFromJson(jsonString);

import 'dart:convert';

PaymentXenditModel paymentXenditModelFromJson(String str) =>
    PaymentXenditModel.fromJson(json.decode(str));

String paymentXenditModelToJson(PaymentXenditModel data) =>
    json.encode(data.toJson());

class PaymentXenditModel {
  String? id;
  String? participantId;
  String? paymentId;
  String? programId;
  String? description;
  String? amount;
  String? email;
  String? externalId;
  String? currency;
  String? idXendit;
  String? userIdXendit;
  String? urlXendit;
  String? status;
  String? merchantName;
  DateTime? expiredAt;
  String? paymentMethod;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullName;
  String? emailUser;
  String? name;
  String? logoUrl;
  String? webUrl;
  String? contact;
  String? emailProgramCategory;
  String? programPaymentName;

  PaymentXenditModel({
    this.id,
    this.participantId,
    this.paymentId,
    this.programId,
    this.description,
    this.amount,
    this.email,
    this.externalId,
    this.currency,
    this.idXendit,
    this.userIdXendit,
    this.urlXendit,
    this.status,
    this.merchantName,
    this.expiredAt,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.emailUser,
    this.name,
    this.logoUrl,
    this.webUrl,
    this.contact,
    this.emailProgramCategory,
    this.programPaymentName,
  });

  factory PaymentXenditModel.fromJson(Map<String, dynamic> json) =>
      PaymentXenditModel(
        id: json["id"],
        participantId: json["participant_id"],
        paymentId: json["payment_id"],
        programId: json["program_id"],
        description: json["description"],
        amount: json["amount"],
        email: json["email"],
        externalId: json["external_id"],
        currency: json["currency"],
        idXendit: json["id_xendit"],
        userIdXendit: json["user_id_xendit"],
        urlXendit: json["url_xendit"],
        status: json["status"],
        merchantName: json["merchant_name"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
        paymentMethod: json["payment_method"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fullName: json["full_name"],
        emailUser: json["email_user"],
        name: json["name"],
        logoUrl: json["logo_url"],
        webUrl: json["web_url"],
        contact: json["contact"],
        emailProgramCategory: json["email_program_category"],
        programPaymentName: json["program_payment_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "participant_id": participantId,
        "payment_id": paymentId,
        "program_id": programId,
        "description": description,
        "amount": amount,
        "email": email,
        "external_id": externalId,
        "currency": currency,
        "id_xendit": idXendit,
        "user_id_xendit": userIdXendit,
        "url_xendit": urlXendit,
        "status": status,
        "merchant_name": merchantName,
        "expired_at": expiredAt?.toIso8601String(),
        "payment_method": paymentMethod,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "full_name": fullName,
        "email_user": emailUser,
        "name": name,
        "logo_url": logoUrl,
        "web_url": webUrl,
        "contact": contact,
        "email_program_category": emailProgramCategory,
        "program_payment_name": programPaymentName,
      };
}

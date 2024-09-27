// To parse this JSON data, do
//
//     final fullPaymentModel = fullPaymentModelFromJson(jsonString);

import 'dart:convert';

FullPaymentModel fullPaymentModelFromJson(String str) =>
    FullPaymentModel.fromJson(json.decode(str));

String fullPaymentModelToJson(FullPaymentModel data) =>
    json.encode(data.toJson());

class FullPaymentModel {
  String? id;
  String? participantId;
  String? programPaymentId;
  String? paymentMethodId;
  String? status;
  dynamic proofUrl;
  String? accountName;
  String? amount;
  dynamic currency;
  String? sourceName;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? programId;
  String? programPaymentsName;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? orderNumber;
  String? idrAmount;
  String? usdAmount;
  String? category;
  String? paymentMethodsName;
  String? type;
  String? imgUrl;
  String? externalId;
  String? xenditStatus;
  dynamic xenditPaymentMethod;
  String? nationality;
  String? gender;
  String? institution;

  FullPaymentModel({
    this.id,
    this.participantId,
    this.programPaymentId,
    this.paymentMethodId,
    this.status,
    this.proofUrl,
    this.accountName,
    this.amount,
    this.currency,
    this.sourceName,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.programId,
    this.programPaymentsName,
    this.description,
    this.startDate,
    this.endDate,
    this.orderNumber,
    this.idrAmount,
    this.usdAmount,
    this.category,
    this.paymentMethodsName,
    this.type,
    this.imgUrl,
    this.externalId,
    this.xenditStatus,
    this.xenditPaymentMethod,
    this.nationality,
    this.gender,
    this.institution,
  });

  factory FullPaymentModel.fromJson(Map<String, dynamic> json) =>
      FullPaymentModel(
        id: json["id"],
        participantId: json["participant_id"],
        programPaymentId: json["program_payment_id"],
        paymentMethodId: json["payment_method_id"],
        status: json["status"],
        proofUrl: json["proof_url"],
        accountName: json["account_name"],
        amount: json["amount"],
        currency: json["currency"],
        sourceName: json["source_name"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        programId: json["program_id"],
        programPaymentsName: json["program_payments_name"],
        description: json["description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        orderNumber: json["order_number"],
        idrAmount: json["idr_amount"],
        usdAmount: json["usd_amount"],
        category: json["category"],
        paymentMethodsName: json["payment_methods_name"],
        type: json["type"],
        imgUrl: json["img_url"],
        externalId: json["external_id"],
        xenditStatus: json["xendit_status"],
        xenditPaymentMethod: json["xendit_payment_method"],
        nationality: json["nationality"],
        gender: json["gender"],
        institution: json["institution"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "participant_id": participantId,
        "program_payment_id": programPaymentId,
        "payment_method_id": paymentMethodId,
        "status": status,
        "proof_url": proofUrl,
        "account_name": accountName,
        "amount": amount,
        "currency": currency,
        "source_name": sourceName,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "program_id": programId,
        "program_payments_name": programPaymentsName,
        "description": description,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "order_number": orderNumber,
        "idr_amount": idrAmount,
        "usd_amount": usdAmount,
        "category": category,
        "payment_methods_name": paymentMethodsName,
        "type": type,
        "img_url": imgUrl,
        "external_id": externalId,
        "xendit_status": xenditStatus,
        "xendit_payment_method": xenditPaymentMethod,
      };
}

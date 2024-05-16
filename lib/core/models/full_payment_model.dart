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
  String? sourceName;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullName;
  String? phoneNumber;
  String? email;
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

  FullPaymentModel({
    this.id,
    this.participantId,
    this.programPaymentId,
    this.paymentMethodId,
    this.status,
    this.proofUrl,
    this.accountName,
    this.amount,
    this.sourceName,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.phoneNumber,
    this.email,
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
        "source_name": sourceName,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
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
      };
}

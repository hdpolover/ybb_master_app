// To parse this JSON data, do
//
//     final dashboardGenderCountModel = dashboardGenderCountModelFromJson(jsonString);

import 'dart:convert';

DashboardGenderCountModel dashboardGenderCountModelFromJson(String str) =>
    DashboardGenderCountModel.fromJson(json.decode(str));

String dashboardGenderCountModelToJson(DashboardGenderCountModel data) =>
    json.encode(data.toJson());

class DashboardGenderCountModel {
  String? gender;
  String? jumlah;

  DashboardGenderCountModel({
    this.gender,
    this.jumlah,
  });

  factory DashboardGenderCountModel.fromJson(Map<String, dynamic> json) =>
      DashboardGenderCountModel(
        gender: json["gender"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "jumlah": jumlah,
      };
}

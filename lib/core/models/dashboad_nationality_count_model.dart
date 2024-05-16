// To parse this JSON data, do
//
//     final dashboardNationalityCountModel = dashboardNationalityCountModelFromJson(jsonString);

import 'dart:convert';

DashboardNationalityCountModel dashboardNationalityCountModelFromJson(
        String str) =>
    DashboardNationalityCountModel.fromJson(json.decode(str));

String dashboardNationalityCountModelToJson(
        DashboardNationalityCountModel data) =>
    json.encode(data.toJson());

class DashboardNationalityCountModel {
  dynamic nationality;
  String? jumlah;

  DashboardNationalityCountModel({
    this.nationality,
    this.jumlah,
  });

  factory DashboardNationalityCountModel.fromJson(Map<String, dynamic> json) =>
      DashboardNationalityCountModel(
        nationality: json["nationality"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "nationality": nationality,
        "jumlah": jumlah,
      };
}

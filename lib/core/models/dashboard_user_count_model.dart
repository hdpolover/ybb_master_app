// To parse this JSON data, do
//
//     final dashboardUserCountModel = dashboardUserCountModelFromJson(jsonString);

import 'dart:convert';

DashboardUserCountModel dashboardUserCountModelFromJson(String str) =>
    DashboardUserCountModel.fromJson(json.decode(str));

String dashboardUserCountModelToJson(DashboardUserCountModel data) =>
    json.encode(data.toJson());

class DashboardUserCountModel {
  DateTime? tanggal;
  String? jumlah;

  DashboardUserCountModel({
    this.tanggal,
    this.jumlah,
  });

  factory DashboardUserCountModel.fromJson(Map<String, dynamic> json) =>
      DashboardUserCountModel(
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "jumlah": jumlah,
      };
}

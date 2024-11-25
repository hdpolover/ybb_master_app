// To parse this JSON data, do
//
//     final documentBatchModel = documentBatchModelFromJson(jsonString);

class DocumentBatchModel {
  String? id;
  String? programId;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? availabilityDate;
  String? customAvailability;
  String? isActive;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  DocumentBatchModel({
    this.id,
    this.programId,
    this.name,
    this.startDate,
    this.endDate,
    this.availabilityDate,
    this.customAvailability,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory DocumentBatchModel.fromJson(Map<String, dynamic> json) =>
      DocumentBatchModel(
        id: json["id"],
        programId: json["program_id"],
        name: json["name"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        availabilityDate: json["availability_date"] == null
            ? null
            : DateTime.parse(json["availability_date"]),
        customAvailability: json["custom_availability"],
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
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "availability_date": availabilityDate?.toIso8601String(),
        "custom_availability": customAvailability,
      };
}

import 'package:ybb_master_app/core/models/program_category.dart';

class Program {
  int? id;
  String? name;
  String? description;
  String? image;
  ProgramCategory? programCategory;
  bool? isActive;

  Program(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.programCategory,
      this.isActive});
}

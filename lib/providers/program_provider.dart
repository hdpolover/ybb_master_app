import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/program/program_model.dart';
import 'package:ybb_master_app/core/models/program/program_category_model.dart';

class ProgramProvider extends ChangeNotifier {
  ProgramModel? _currentProgram;
  List<ProgramModel> _programs = [];
  List<ProgramCategoryModel> _programCategories = [];

  List<ProgramCategoryModel> get programCategories => _programCategories;

  set programCategories(List<ProgramCategoryModel> programCategories) {
    _programCategories = programCategories;
    notifyListeners();
  }

  ProgramModel? get currentProgram => _currentProgram;

  set currentProgram(ProgramModel? currentProgram) {
    _currentProgram = currentProgram;
    notifyListeners();
  }

  void updateProgram(ProgramModel program) {
    _currentProgram = program;
    notifyListeners();
  }

  void removeCurrentProgram() {
    _currentProgram = null;
    notifyListeners();
  }

  List<ProgramModel> get programs => _programs;

  set programs(List<ProgramModel> programs) {
    _programs = programs;
    notifyListeners();
  }

  void addProgram(ProgramModel program) {
    _programs.add(program);
    notifyListeners();
  }

  void removeProgram(ProgramModel program) {
    _programs.remove(program);
    notifyListeners();
  }
}

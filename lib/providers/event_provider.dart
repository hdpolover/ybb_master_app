import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/program.dart';

class ProgramProvider extends ChangeNotifier {
  List<Program> _programs = [];

  List<Program> get programs => _programs;

  set programs(List<Program> programs) {
    _programs = programs;
    notifyListeners();
  }

  void addProgram(Program program) {
    _programs.add(program);
    notifyListeners();
  }

  void removeProgram(Program program) {
    _programs.remove(program);
    notifyListeners();
  }
}

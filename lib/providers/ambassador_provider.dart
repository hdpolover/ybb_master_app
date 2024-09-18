import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/ambassador_model.dart';

class AmbassadorProvider extends ChangeNotifier {
  List<AmbassadorModel> _ambassadors = [];

  List<AmbassadorModel> get ambassadors => _ambassadors;

  set ambassadors(List<AmbassadorModel> ambassadors) {
    _ambassadors = ambassadors;
    notifyListeners();
  }

  void addAmbassador(AmbassadorModel ambassador) {
    _ambassadors.add(ambassador);
    notifyListeners();
  }

  void removeAmbassador(AmbassadorModel ambassador) {
    _ambassadors.remove(ambassador);
    notifyListeners();
  }

  void updateAmbassador(AmbassadorModel ambassador) {
    int index =
        _ambassadors.indexWhere((element) => element.id == ambassador.id);
    _ambassadors[index] = ambassador;
    notifyListeners();
  }

  void removeAmbassadorById(String id) {
    _ambassadors.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearAmbassadors() {
    _ambassadors.clear();
    notifyListeners();
  }
}

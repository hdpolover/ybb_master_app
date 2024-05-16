import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/admin/admin_model.dart';

class AdminProvider extends ChangeNotifier {
  AdminModel? _currentAdmin;
  List<AdminModel> _admins = [];

  AdminModel? get currentAdmin => _currentAdmin;

  set currentAdmin(AdminModel? admin) {
    _currentAdmin = admin;
    notifyListeners();
  }

  void updateAdmin(AdminModel admin) {
    _currentAdmin = admin;
    notifyListeners();
  }

  void removeCurrentAdmin() {
    _currentAdmin = null;
    notifyListeners();
  }

  void updateAdminProfile(AdminModel admin) {
    _currentAdmin = admin;
    notifyListeners();
  }

  List<AdminModel> get admins => _admins;

  set admins(List<AdminModel> admins) {
    _admins = admins;
    notifyListeners();
  }

  void addAdmin(AdminModel admin) {
    _admins.add(admin);
    notifyListeners();
  }

  void removeAdmin(AdminModel admin) {
    _admins.remove(admin);
    notifyListeners();
  }
}

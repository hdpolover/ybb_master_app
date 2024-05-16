import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/dashboad_nationality_count_model.dart';
import 'package:ybb_master_app/core/models/dashboard_gender_count_model.dart';
import 'package:ybb_master_app/core/models/dashboard_user_count_model.dart';

class DashboardProvider extends ChangeNotifier {
  List<DashboardNationalityCountModel> _nationalityCount = [];
  List<DashboardUserCountModel> _userCount = [];
  List<DashboardGenderCountModel> _genderCount = [];

  List<DashboardGenderCountModel> get genderCount => _genderCount;

  set genderCount(List<DashboardGenderCountModel> genderCount) {
    _genderCount = genderCount;
    notifyListeners();
  }

  void addGenderCount(DashboardGenderCountModel genderCount) {
    _genderCount.add(genderCount);
    notifyListeners();
  }

  List<DashboardUserCountModel> get userCount => _userCount;

  set userCount(List<DashboardUserCountModel> userCount) {
    _userCount = userCount;
    notifyListeners();
  }

  void addUserCount(DashboardUserCountModel userCount) {
    _userCount.add(userCount);
    notifyListeners();
  }

  set nationalityCount(List<DashboardNationalityCountModel> nationalityCount) {
    _nationalityCount = nationalityCount;
    notifyListeners();
  }

  List<DashboardNationalityCountModel> get nationalityCount =>
      _nationalityCount;

  // add data
  void addNationalityCount(DashboardNationalityCountModel nationalityCount) {
    _nationalityCount.add(nationalityCount);
    notifyListeners();
  }
}

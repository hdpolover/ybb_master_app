//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/dashboad_nationality_count_model.dart';
import 'package:ybb_master_app/core/models/dashboard_gender_count_model.dart';
import 'package:ybb_master_app/core/models/dashboard_user_count_model.dart';

class DashboardService {
  String dashboardUrl = '${AppStringConstants.apiUrl}/dashboard_admin';

  Future<List<DashboardNationalityCountModel>> getNationalities() async {
    var url = Uri.parse('$dashboardUrl/participant_country_count');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<DashboardNationalityCountModel> value = [];

        for (var prog in data) {
          value.add(DashboardNationalityCountModel.fromJson(prog));
        }

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DashboardUserCountModel>> getUserCountByDay() async {
    var url = Uri.parse('$dashboardUrl/user_count_by_day');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<DashboardUserCountModel> value = [];

        for (var prog in data) {
          value.add(DashboardUserCountModel.fromJson(prog));
        }

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DashboardGenderCountModel>> getGenderCount() async {
    var url = Uri.parse('$dashboardUrl/participant_stats?param=gender');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<DashboardGenderCountModel> value = [];

        for (var prog in data) {
          value.add(DashboardGenderCountModel.fromJson(prog));
        }

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

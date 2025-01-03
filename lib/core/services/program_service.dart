//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/program/program_model.dart';
import 'package:ybb_master_app/core/models/program_info_by_url_model.dart';

class ProgramService {
  String programUrl = '${AppStringConstants.apiUrl}/programs';

  Future<List<ProgramModel>> getAll() async {
    var url = Uri.parse('$programUrl/');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<ProgramModel> programs = [];

        for (var prog in data) {
          programs.add(ProgramModel.fromJson(prog));
        }

        return programs;
      } else {
        throw Exception('Failed to get programs');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProgramInfoByUrlModel> getProgramInfo(String link) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/program_categories/web?url=$link');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        return ProgramInfoByUrlModel.fromJson(data);
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}

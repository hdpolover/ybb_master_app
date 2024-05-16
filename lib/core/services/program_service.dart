//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/program/program_model.dart';

class ProgramService {
  String programUrl = '${AppStringConstants.apiUrl}/programs';

  Future<List<ProgramModel>> getAll() async {
    var url = Uri.parse('$programUrl/');

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
}

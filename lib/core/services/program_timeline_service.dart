//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/program_timeline_model.dart';

class ProgramTimelineService {
  String baseUrl = '${AppStringConstants.apiUrl}/program_schedules';

  Future<List<ProgramTimelineModel>> getAll(String programId) async {
    var url = Uri.parse('$baseUrl?program_id=$programId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<ProgramTimelineModel> value = [];

        for (var prog in data) {
          value.add(ProgramTimelineModel.fromJson(prog));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProgramTimelineModel> add(ProgramTimelineModel data) async {
    var url = Uri.parse('$baseUrl/save');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        ProgramTimelineModel value = ProgramTimelineModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    var url = Uri.parse('$baseUrl/delete?id=$id');

    try {
      var response = await http.get(url);

      if (response.statusCode != 200) {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProgramTimelineModel> update(ProgramTimelineModel data) async {
    var url = Uri.parse('$baseUrl/update');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        ProgramTimelineModel value = ProgramTimelineModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

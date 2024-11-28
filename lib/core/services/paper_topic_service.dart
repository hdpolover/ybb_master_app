//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';

class PaperTopicService {
  String baseUrl = '${AppStringConstants.apiUrl}/paper_topics';

  Future<List<PaperTopicModel>> getAll(String programId) async {
    var url = Uri.parse('$baseUrl/list?program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperTopicModel> value = [];

        for (var i in data) {
          value.add(PaperTopicModel.fromJson(i));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PaperTopicModel> add(PaperTopicModel data) async {
    var url = Uri.parse('$baseUrl/save');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        PaperTopicModel value = PaperTopicModel.fromJson(data);

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

  Future<PaperTopicModel> update(PaperTopicModel data) async {
    var url = Uri.parse('$baseUrl/update/${data.id}');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        PaperTopicModel value = PaperTopicModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_topic_model.dart';

class PaperReviewerTopicService {
  String baseUrl = '${AppStringConstants.apiUrl}/paper_reviewer_topics';

  Future<List<PaperReviewerTopicModel>> getAll() async {
    var url = Uri.parse('$baseUrl/');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperReviewerTopicModel> value = [];

        for (var i in data) {
          value.add(PaperReviewerTopicModel.fromJson(i));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PaperReviewerTopicModel>> getById(String reviewerId) async {
    var url = Uri.parse('$baseUrl/list?paper_reviewer_id=$reviewerId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperReviewerTopicModel> value = [];

        for (var i in data) {
          value.add(PaperReviewerTopicModel.fromJson(i));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PaperReviewerTopicModel> add(PaperReviewerTopicModel data) async {
    var url = Uri.parse('$baseUrl/save');

    try {
      var response = await http.post(url, body: data.toJson());

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        PaperReviewerTopicModel value = PaperReviewerTopicModel.fromJson(data);

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

  Future<PaperReviewerTopicModel> update(PaperReviewerTopicModel data) async {
    var url = Uri.parse('$baseUrl/update/${data.id}');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        PaperReviewerTopicModel value = PaperReviewerTopicModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';

class PaperReviewerService {
  String baseUrl = '${AppStringConstants.apiUrl}/paper_reviewers';

  Future<List<PaperReviewerModel>> getAll(String programId) async {
    var url = Uri.parse('$baseUrl/list?program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperReviewerModel> value = [];

        for (var i in data) {
          value.add(PaperReviewerModel.fromJson(i));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PaperReviewerModel> add(PaperReviewerModel data) async {
    var url = Uri.parse('$baseUrl/save');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        PaperReviewerModel value = PaperReviewerModel.fromJson(data);

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

  Future<PaperReviewerModel> update(PaperReviewerModel data) async {
    var url = Uri.parse('$baseUrl/update/${data.id}');

    print(data.toString());

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        PaperReviewerModel value = PaperReviewerModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PaperReviewerModel> signIn(String email, String password) async {
    var url = Uri.parse('$baseUrl/signin?email=$email&password=$password');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperReviewerModel> value = [];

        for (var i in data) {
          value.add(PaperReviewerModel.fromJson(i));
        }

        return value[0];
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/document_batch_model.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/models/program_timeline_model.dart';

class ProgramDocumentSettingService {
  String baseUrl = '${AppStringConstants.apiUrl}/program_document_settings';

  Future<List<DocumentBatchModel>> getAll(String programId) async {
    var url = Uri.parse('$baseUrl/list?program_id=$programId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<DocumentBatchModel> value = [];

        for (var prog in data) {
          value.add(DocumentBatchModel.fromJson(prog));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentBatchModel> add(DocumentBatchModel data) async {
    var url = Uri.parse('$baseUrl/save');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        DocumentBatchModel value = DocumentBatchModel.fromJson(data);

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

  Future<DocumentBatchModel> update(DocumentBatchModel data) async {
    var url = Uri.parse('$baseUrl/update/${data.id}');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        DocumentBatchModel value = DocumentBatchModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';

class ProgramLoaService {
  String baseUrl = '${AppStringConstants.apiUrl}/program_loas';

  Future<List<ProgramDocumentModel>> getAll(String programId) async {
    var url = Uri.parse('$baseUrl/list?program_id=$programId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<ProgramDocumentModel> value = [];

        for (var prog in data) {
          value.add(ProgramDocumentModel.fromJson(prog));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProgramDocumentModel> add(ProgramDocumentModel data) async {
    var url = Uri.parse('$baseUrl/save');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        ProgramDocumentModel value = ProgramDocumentModel.fromJson(data);

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

  Future<ProgramDocumentModel> update(ProgramDocumentModel data) async {
    var url = Uri.parse('$baseUrl/update/${data.id}');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        ProgramDocumentModel value = ProgramDocumentModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';

class ProgramCertificateService {
  String baseUrl = '${AppStringConstants.apiUrl}/program_certificates';

  Future<List<ProgramCertificateModel>> getAll(String programId) async {
    var url = Uri.parse('$baseUrl/list?program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<ProgramCertificateModel> value = [];

        for (var prog in data) {
          value.add(ProgramCertificateModel.fromJson(prog));
        }

        return value;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProgramCertificateModel> add(
      ProgramCertificateModel data, Map<String, dynamic> imageData) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppStringConstants.apiUrl}/program_certificates/save'),
    );

    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      // 'Accept': '*/*',
      // "Access-Control-Allow-Origin": "*",
    };
    request.files.add(
      http.MultipartFile.fromBytes(
        'template_url',
        imageData['file_bytes'],
        filename: imageData['file_name'],
      ),
    );
    request.fields.addAll({
      'program_id': data.programId!,
      'title': data.title!,
      'description': data.description!,
    });

    print(data);
    request.headers.addAll(headers);

    try {
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        return ProgramCertificateModel.fromJson(data);
      } else {
        print(response.body);
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
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

  Future<ProgramCertificateModel> update(ProgramCertificateModel data) async {
    var url = Uri.parse('$baseUrl/update/${data.id}');

    try {
      var response = await http.post(url, body: data.toJson());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        ProgramCertificateModel value = ProgramCertificateModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

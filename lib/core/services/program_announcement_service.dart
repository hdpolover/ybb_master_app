import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/program_announcement/program_announcement_model.dart';
import 'package:ybb_master_app/core/models/users/participant_essay_model.dart';

class ProgramAnnouncementService {
  Future<List<ProgramAnnouncementModel>> getAll(String? programId) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/program_announcements/list?program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'] as List;

        List<ProgramAnnouncementModel> value = data
            .map((item) => ProgramAnnouncementModel.fromJson(item))
            .toList();

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> delete(String id) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/program_announcements/delete?id=$id');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<ProgramAnnouncementModel> save(Map<String, dynamic> data) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppStringConstants.apiUrl}/program_announcements/save'),
    );

    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      // 'Accept': '*/*',
      // "Access-Control-Allow-Origin": "*",
    };
    request.files.add(
      http.MultipartFile.fromBytes(
        'img_url',
        data['file_bytes'],
        filename: data['file_name'],
      ),
    );
    request.fields.addAll({
      'program_id': data['program_id'],
      'title': data['title'],
      'description': data['description'],
      'visible_to': data['visible_to'],
    });

    print(data);
    request.headers.addAll(headers);

    try {
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        return ProgramAnnouncementModel.fromJson(data);
      } else {
        print(response.body);
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> encrpytId(String id) async {
    var url = Uri.parse('${AppStringConstants.apiUrl}/news/encrypt?id=$id');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ParticipantEssayModel>> getEssayByParticipantId(
      String? id) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/participant_essays?participant_id=$id');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<ParticipantEssayModel> value = [];

        for (var prog in data) {
          value.add(ParticipantEssayModel.fromJson(prog));
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

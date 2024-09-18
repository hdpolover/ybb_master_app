import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/users/participant_essay_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';

class ParticipantService {
  Future<List<ParticipantModel>> getAll(String? programId) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/participants/participant_program?program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'] as List;

        List<ParticipantModel> value =
            data.map((item) => ParticipantModel.fromJson(item)).toList();

        return value;
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
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}

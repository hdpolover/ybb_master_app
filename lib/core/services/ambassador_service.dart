//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/ambassador_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';

class AmbassadorService {
  String dashboardUrl = '${AppStringConstants.apiUrl}/ambassadors';

  Future<List<AmbassadorModel>> getAllByProgram(String id) async {
    var url = Uri.parse('$dashboardUrl/ambassador_program?program_id=$id');

    print(url);
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<AmbassadorModel> value = [];

        for (var prog in data) {
          value.add(AmbassadorModel.fromJson(prog));
        }

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AmbassadorModel> add(Map<String, dynamic> data) async {
    var url = Uri.parse('$dashboardUrl/save');

    try {
      var response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        AmbassadorModel value = AmbassadorModel.fromJson(data);

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ParticipantModel>> getReferredParticipants(String refCode) {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/participants/list_ambassador?ref_code=$refCode');

    print(url);

    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<ParticipantModel> participants = [];

        for (var part in data) {
          participants.add(ParticipantModel.fromJson(part));
        }

        return participants;
      } else {
        return [];
      }
    });
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';

class NotificationService {
  Future<bool> sendEmail(String emails, String programId) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/notifications/notify_documents?emails=$emails&program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['status'];

        return data;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}

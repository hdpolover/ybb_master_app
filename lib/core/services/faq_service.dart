import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/faq_model.dart';

class FaqService {
  Future<List<FaqModel>> getProgramFaqs(String? id) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/program_faqs/list_program?program_id=$id');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'] as List;

        List<FaqModel> value =
            data.map((photo) => FaqModel.fromJson(photo)).toList();

        return value;
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}

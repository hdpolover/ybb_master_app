import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/paper_detail_model.dart';

class PaperDetailService {
  Future<List<PaperDetailModel>?> getAll(String? programId) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/paper_details/list?program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperDetailModel> papers = [];

        for (var paper in data) {
          papers.add(PaperDetailModel.fromJson(paper));
        }

        return papers;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}

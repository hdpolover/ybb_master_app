import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/paper_abstract_model.dart';

class PaperAbstractService {
  Future<List<PaperAbstractModel>?> getAll(String? programId) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/paper_abstracts/list?program_id=$programId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperAbstractModel> papers = [];

        for (var paper in data) {
          papers.add(PaperAbstractModel.fromJson(paper));
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

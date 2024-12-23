import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';

class PaperAuthorService {
  Future<List<PaperAuthorModel>?> getAll(String? paperDetailId) async {
    var url = Uri.parse(
        '${AppStringConstants.apiUrl}/paper_authors/list?paper_detail_id=$paperDetailId');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperAuthorModel> authors = [];

        for (var author in data) {
          authors.add(PaperAuthorModel.fromJson(author));
        }

        return authors;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}

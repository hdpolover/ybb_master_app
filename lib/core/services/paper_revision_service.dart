import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/paper_abstract_model.dart';
import 'package:ybb_master_app/core/models/paper_revision_model.dart';

class PaperRevisionService {
  Future<List<PaperRevisionModel>?> getAll() async {
    var url = Uri.parse('${AppStringConstants.apiUrl}/paper_revisions');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<PaperRevisionModel> papers = [];

        for (var paper in data) {
          papers.add(PaperRevisionModel.fromJson(paper));
        }

        return papers;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PaperRevisionModel> save(PaperRevisionModel paperRevision) async {
    var url = Uri.parse('${AppStringConstants.apiUrl}/paper_revisions/save');

    try {
      var response = await http.post(
        url,
        body: paperRevision.toJson(),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        return PaperRevisionModel.fromJson(data);
      } else {
        throw Exception('Failed to save paper revision');
      }
    } catch (e) {
      rethrow;
    }
  }
}

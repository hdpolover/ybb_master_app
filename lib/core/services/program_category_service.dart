//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/program/program_category_model.dart';

class ProgramCategoryService {
  String programCategoriesUrl =
      '${AppStringConstants.apiUrl}/program_categories';

  Future<List<ProgramCategoryModel>> getAll() async {
    var url = Uri.parse('$programCategoriesUrl/');

    print(url);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<ProgramCategoryModel> categories = [];

        for (var category in data) {
          categories.add(ProgramCategoryModel.fromJson(category));
        }

        return categories;
      } else {
        throw Exception('Failed to get program categories');
      }
    } catch (e) {
      rethrow;
    }
  }
}

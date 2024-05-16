//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/admin/admin_model.dart';

class AdminService {
  String adminUrl = '${AppStringConstants.apiUrl}/admins';

  Future<AdminModel> login(String email, String password) async {
    var url = Uri.parse('$adminUrl/login');

    print(url);

    // Login logic
    try {
      var response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return AdminModel.fromJson(data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAdmin() async {
    // Add admin logic
  }
  Future<void> removeAdmin() async {
    // Remove admin logic
  }
  Future<void> updateAdmin() async {
    // Update admin logic
  }
  Future<void> getAdmin() async {
    // Get admin logic
  }
  Future<void> getAllAdmins() async {
    // Get all admins logic
  }
}

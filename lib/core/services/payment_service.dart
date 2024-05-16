//import http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ybb_master_app/core/constants/string_constants.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';

class PaymentService {
  String programUrl = '${AppStringConstants.apiUrl}/payments';

  Future<List<FullPaymentModel>> getAll() async {
    var url = Uri.parse('$programUrl/');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];

        List<FullPaymentModel> value = [];

        for (var prog in data) {
          value.add(FullPaymentModel.fromJson(prog));
        }

        return value;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> sendInvoice(int id) async {
    var url = Uri.parse('$programUrl/send_invoice/$id');

    try {
      var response = await http.post(url, body: {
        'id': id.toString(),
      });

      return "";
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    var url = Uri.parse('$programUrl/update_status/$id');

    try {
      var response = await http.post(
        url,
        body: {
          'status': status.toString(),
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

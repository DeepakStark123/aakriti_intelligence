import 'dart:convert';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  static const String baseUrl = AppStrings.baseUrl;

  static Future<Response> getApi(
      {required String endpoint, Map<String, String>? headers}) async {
    var url = "$baseUrl$endpoint";
    debugPrint("URL = $url");
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers ?? {'Content-Type': 'application/json'},
    );
    return response;
  }

  static Future<Response> postApi({
    required String endpoint,
    required Object body,
    Map<String, String>? headers,
  }) async {
    var url = "$baseUrl/$endpoint";
    debugPrint("URL = $url");
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      body: jsonEncode(body),
      headers: headers ?? {'Content-Type': 'application/json'},
    );
    return response;
  }

  // static Map<String, dynamic> _handleResponse(http.Response response) {
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception(
  //         'Failed to load data. Status code: ${response.statusCode}');
  //   }
  // }
}

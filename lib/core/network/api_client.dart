import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = ApiConfig.baseUrl;

  /// GET request universal function
  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // returns Map<String, dynamic>
    } else {
      throw Exception("HTTP ${response.statusCode} - ${response.reasonPhrase}");
    }
  }
}

class ApiConfig {
  // Ganti sesuai server Laravel-mu
  static const String baseUrl = "http://127.0.0.1:8000";

  // Endpoints
  static const String warehouse = "/api/cangku";
  static const String chanpinxian = "/api/chanpinxian";
  static const String caozuo = "/api/caozuo";
  static const String fahuo = "/api/fahuo";
  static const String fuzhao = "/api/fuzhao";
  static const String fuzhaopi = "/api/fuzhaopi";
}

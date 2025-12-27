// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiClient {
//   static const String baseUrl = ApiConfig.baseUrl;

//   /// GET request universal function
//   static Future<dynamic> get(String endpoint) async {
//     final url = Uri.parse("$baseUrl$endpoint");

//     final response = await http.get(
//       url,
//       headers: {"Accept": "application/json"},
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body); // returns Map<String, dynamic>
//     } else {
//       throw Exception("HTTP ${response.statusCode} - ${response.reasonPhrase}");
//     }
//   }
// }

// class ApiConfig {
//   // Ganti sesuai server Laravel-mu
//   static const String baseUrl = "http://127.0.0.1:8000";

//   // Endpoints
//   static const String warehouse = "/api/cangku";
//   static const String chanpinxian = "/api/chanpinxian";
//   static const String caozuo = "/api/caozuo";
//   static const String fahuo = "/api/fahuo";
//   static const String fuzhao = "/api/fuzhao";
//   static const String fuzhaopi = "/api/fuzhaopi";
//   static const String jiesuan = "/api/jiesuan";
//   static const String jiliang = "/api/jiliang";
//   static const String jiliangji = "/api/jiliangji";
//   static const String juese = "/api/juese";
//   static const String kehufu = "/api/kehufu";
//   static const String kehuli = "/api/kehuli";
//   static const String kehuxin = "/api/kehuxin";
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = ApiConfig.baseUrl;

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        // "X-API-KEY": "your-secret-key", // optional security
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("HTTP ${response.statusCode} - ${response.body}");
    }
  }
}

class ApiConfig {
  /// GANTI ke Flask server
  // static const String baseUrl = "http://127.0.0.1:8000";
  static const String baseUrl = "http://192.168.8.181:8000";

  static const String warehouse = "/warehouse-info";
  static const String chanpinxian = "/production-line";
  static const String caozuo = "/operation-log";
  static const String fahuo = "/delivery-order";
  static const String fuzhao = "/conclusion-detect";
  static const String fuzhaopi = "/operation-batch";
  static const String jiesuan = "/settlement";
  static const String jiliang = "/measurement-unit";
  static const String jiliangji = "/measurement-ins";
  static const String juese = "/user-role";
  static const String kehufu = "/customer-goods";
  static const String kehuli = "/customer-contacts";
  static const String kehuxin = "/customer-info";
  static const String zuzhi = "/organ-structure";
}

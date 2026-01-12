// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiClient {
//   static const String baseUrl = ApiConfig.baseUrl;

//   static Future<Map<String, dynamic>> get(String endpoint) async {
//     final url = Uri.parse("$baseUrl$endpoint");

//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "application/json",
//         // "X-API-KEY": "your-secret-key", // optional security
//       },
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("HTTP ${response.statusCode} - ${response.body}");
//     }
//   }
// }

// class ApiConfig {
//   /// GANTI ke Flask server
//   // static const String baseUrl = "http://127.0.0.1:8000";
//   // static const String baseUrl = "http://192.168.8.181:8000";
//   static const String baseUrl = "https://erp.fanm.cloud";

//   static const String warehouse = "/warehouse-info";
//   static const String chanpinxian = "/production-line";
//   static const String caozuo = "/operation-log";
//   static const String fahuo = "/delivery-order";
//   static const String fuzhao = "/conclusion-detect";
//   static const String fuzhaopi = "/operation-batch";
//   static const String jiesuan = "/settlement";
//   static const String jiliang = "/measurement-unit";
//   static const String jiliangji = "/measurement-ins";
//   static const String juese = "/user-role";
//   static const String kehufu = "/customer-goods";
//   static const String kehuli = "/customer-contacts";
//   static const String kehuxin = "/customer-info";
//   static const String zuzhi = "/organ-structure";
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = ApiConfig.baseUrl;

  /// ======================
  /// GET
  /// ======================
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("HTTP ${response.statusCode} - ${response.body}");
    }
  }

  /// ======================
  /// POST
  /// ======================
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception("HTTP ${response.statusCode} - ${response.body}");
    }
  }
}

class ApiConfig {
  /// Flask API
  // static const String baseUrl = "http://127.0.0.1:8000";
  static const String baseUrl = "http://192.168.8.181:8000";
  // static const String baseUrl = "https://erp.fanm.cloud";

  // ===== AUTH =====
  // static const String login = "/api/auth/login";
  static const String login = "/api/auth/login";
  static const String register = "/api/auth/register";

  // ===== DATA =====
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
  static const String weituodan = "/customer-order";
  static const String weituodanleixing = "/order-type";
  static const String weituodanrenwu = "/detail-task";
  static const String pichiziliang = "/main-QC";
  static const String processManage = "/process-manage";
  static const String taskQueue1 = "/task-queue1";
}

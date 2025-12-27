import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/caozuo_model.dart';

class CaozuoProvider extends ChangeNotifier {
  bool loading = false;
  List<CaoZuo> data = [];
  String? errorMessage;

  Future<void> fetchCaozuo() async {
    try {
      loading = true;
      errorMessage = null;

      // ❌ JANGAN notify di sini

      final response = await ApiClient.get(ApiConfig.caozuo);

      // if (response == null || response["data"] == null) {
      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => CaoZuo.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Error $e");
      errorMessage = "Cannot connect to server";
      data = [];
    } finally {
      loading = false;
      notifyListeners(); // ✅ SATU-SATUNYA notify
    }
  }
}

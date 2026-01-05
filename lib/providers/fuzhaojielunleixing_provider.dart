import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/fuzhaojielunleixing_model.dart';

class FuzhaoProvider extends ChangeNotifier {
  bool loading = false;
  List<Fuzhao> data = [];
  String? errorMessage;

  Future<void> fetchFuzhao() async {
    try {
      loading = true;
      errorMessage = null;

      // ❌ JANGAN notify di sini

      final response = await ApiClient.get(ApiConfig.fuzhao);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Fuzhao.fromJson(e)).toList();
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

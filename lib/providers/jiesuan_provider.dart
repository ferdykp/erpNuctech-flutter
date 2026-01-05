import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/jiesuan_model.dart';

class JiesuanProvider extends ChangeNotifier {
  bool loading = false;
  List<Jiesuan> data = [];
  String? errorMessage;

  Future<void> fetchJiesuan() async {
    try {
      loading = true;
      errorMessage = null;

      // ❌ JANGAN notify di sini

      final response = await ApiClient.get(ApiConfig.jiesuan);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Jiesuan.fromJson(e)).toList();
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

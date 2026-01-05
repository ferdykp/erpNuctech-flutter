import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/fahuo_model.dart';

class FahuoProvider extends ChangeNotifier {
  bool loading = false;
  List<Fahuo> data = [];
  String? errorMessage;

  Future<void> fetchFahuo() async {
    try {
      loading = true;
      errorMessage = null;

      // ❌ JANGAN notify di sini

      final response = await ApiClient.get(ApiConfig.fahuo);

      // if (response == null || response["data"] == null) {
      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Fahuo.fromJson(e)).toList();
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

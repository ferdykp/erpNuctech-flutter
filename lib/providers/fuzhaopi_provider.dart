import 'package:flutter/material.dart';
import '../core//network/api_client.dart';
import '../models/fuzhaopi_model.dart';

class FuzhaopiProvider extends ChangeNotifier {
  bool loading = false;
  List<Fuzhaopi> data = [];
  String? errorMessage;

  Future<void> fetchFuzhaopi() async {
    try {
      loading = true;
      errorMessage = null;

      // ❌ JANGAN notify di sini

      final response = await ApiClient.get(ApiConfig.fuzhaopi);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Fuzhaopi.fromJson(e)).toList();
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

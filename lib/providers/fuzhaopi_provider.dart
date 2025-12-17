import 'package:flutter/material.dart';
import '../core//network/api_client.dart';
import '../models/fuzhaopi_model.dart';

class FuzhaopiProvider extends ChangeNotifier {
  bool loading = false;
  List<Fuzhaopi> data = [];

  String? errorMessage;
  Future<void> fetchFuzhaopi() async {
    loading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(ApiConfig.fuzhaopi);
      // List list = response["data"];

      if (response == null || response["data"] == null) {
        // =================== 🆕 ADDED ===================
        errorMessage = "Failed to load data";
        data = [];
        // =================================================
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Fuzhaopi.fromJson(e)).toList();
      }

      // data = list.map((e) => Fuzhao.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error $e");
      errorMessage = "Cannot connect to server";
      data = [];
    }
    loading = false;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/fuzhaojielunleixing_model.dart';

class FuzhaoProvider extends ChangeNotifier {
  bool loading = false;
  List<Fuzhao> data = [];

  String? errorMessage;

  Future<void> fetchFuzhao() async {
    loading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(ApiConfig.fahuo);
      // List list = response["data"];

      if (response == null || response["data"] == null) {
        // =================== 🆕 ADDED ===================
        errorMessage = "Failed to load data";
        data = [];
        // =================================================
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Fuzhao.fromJson(e)).toList();
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

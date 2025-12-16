import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/fahuo_model.dart';

class FahuoProvider extends ChangeNotifier {
  bool loading = false;
  List<Fahuo> data = [];

  String? errorMessage;

  Future<void> fetchFahuo() async {
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
        data = dataList.map((e) => Fahuo.fromJson(e)).toList();
      }
      // data = list.map((e) => Fahuo.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error $e");
      errorMessage = "Cannot connect to server";
      data = [];
    }
    loading = false;
    notifyListeners();
  }
}

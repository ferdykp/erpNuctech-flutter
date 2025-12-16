import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/caozuo_model.dart';

class CaozuoProvider extends ChangeNotifier {
  bool loading = false;
  List<CaoZuo> data = [];

  String? errorMessage;

  Future<void> fetchCaoZuo() async {
    loading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(ApiConfig.caozuo);
      // List list = response["data"];
      if (response == null || response["data"] == null) {
        // =================== 🆕 ADDED ===================
        errorMessage = "Failed to load data";
        data = [];
        // =================================================
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => CaoZuo.fromJson(e)).toList();
      }
      // data = list.map((e) => ChanPinXian.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error $e");
      errorMessage = "Cannot connect to server";
      data = [];
    }
    loading = false;
    notifyListeners();
  }
}

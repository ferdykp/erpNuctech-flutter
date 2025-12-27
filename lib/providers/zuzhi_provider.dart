import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/zuzhi_model.dart';

class ZuzhiProvider extends ChangeNotifier {
  bool loading = false;
  List<Zuzhi> data = [];
  String? errorMessage;

  Future<void> fetchZuzhi() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.zuzhi);
      // if (response == null || response["data"] == null) {
      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Zuzhi.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Error $e");
      errorMessage = "Cannot connect to server";
      data = [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

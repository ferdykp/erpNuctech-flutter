import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/weituodanleixing_model.dart';

class WeituodanleixingProvider extends ChangeNotifier {
  bool loading = false;
  List<Weituodanleixing> data = [];
  String? errorMessage;

  Future<void> fetchWeituodanleixing() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.weituodanleixing);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Weituodanleixing.fromJson(e)).toList();
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

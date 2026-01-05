import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/weituodanrenwu_model.dart';

class WeituodanrenwuProvider extends ChangeNotifier {
  bool loading = false;
  List<Weituodanrenwu> data = [];
  String? errorMessage;

  Future<void> fetchWeituodanrenwu() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.weituodanrenwu);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Weituodanrenwu.fromJson(e)).toList();
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

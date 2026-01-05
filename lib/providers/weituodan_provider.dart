import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/weituodan_model.dart';

class WeituodanProvider extends ChangeNotifier {
  bool loading = false;
  List<Weituodan> data = [];
  String? errorMessage;

  Future<void> fetchWeituodan() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.weituodan);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Weituodan.fromJson(e)).toList();
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

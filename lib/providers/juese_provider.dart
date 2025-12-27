import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/juese_model.dart';

class JueseProvider extends ChangeNotifier {
  bool loading = false;
  List<Juese> data = [];
  String? errorMessage;

  Future<void> fetchJuese() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.juese);

      if (response == null || response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Juese.fromJson(e)).toList();
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

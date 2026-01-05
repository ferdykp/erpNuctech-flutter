import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/kehuli_model.dart';

class KehuliProvider extends ChangeNotifier {
  bool loading = false;
  List<Kehuli> data = [];
  String? errorMessage;

  Future<void> fetchKehuli() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.kehuli);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Kehuli.fromJson(e)).toList();
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

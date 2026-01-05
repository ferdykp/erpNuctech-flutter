import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/jiliangji_model.dart';

class JiliangjiProvider extends ChangeNotifier {
  bool loading = false;
  List<Jiliangji> data = [];
  String? errorMessage;

  Future<void> fetchJiliangji() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.jiliangji);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Jiliangji.fromJson(e)).toList();
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

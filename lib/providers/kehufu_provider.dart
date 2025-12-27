import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/kehufu_model.dart';

class KehufuProvider extends ChangeNotifier {
  bool loading = false;
  List<Kehufu> data = [];
  String? errorMessage;

  Future<void> fetchKehufu() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.kehufu);

      if (response == null || response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Kehufu.fromJson(e)).toList();
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

import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/chanpinxian_model.dart';

class ChanPinXianProvider extends ChangeNotifier {
  bool loading = false;
  List<ChanPinXian> data = [];
  String? errorMessage;

  Future<void> fetchChanpinxian() async {
    try {
      loading = true;
      errorMessage = null;

      // ❌ JANGAN notify di sini

      final response = await ApiClient.get(ApiConfig.chanpinxian);

      // if (response == null || response["data"] == null) {
      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => ChanPinXian.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Error $e");
      errorMessage = "Cannot connect to server";
      data = [];
    } finally {
      loading = false;
      notifyListeners(); // ✅ SATU-SATUNYA notify
    }
  }
}

import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/chanpinxian_model.dart';

class ChanPinXianProvider extends ChangeNotifier {
  bool loading = false;
  List<ChanPinXian> data = [];

  String? errorMessage;

  Future<void> fetchChanpinxian() async {
    loading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(ApiConfig.chanpinxian);
      // List list = response["data"];
      if (response == null || response["data"] == null) {
        // =================== 🆕 ADDED ===================
        errorMessage = "Failed to load data";
        data = [];
        // =================================================
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => ChanPinXian.fromJson(e)).toList();
      }
      // data = list.map((e) => ChanPinXian.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error ChanPinXian: $e");
      errorMessage = "Cannot connect to server";
      data = [];
    }

    loading = false;
    notifyListeners();
  }
}

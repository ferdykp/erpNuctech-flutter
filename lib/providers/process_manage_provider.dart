import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/process_manage_model.dart';

class ProcessManageProvider extends ChangeNotifier {
  bool loading = false;
  List<ProcessManageModel> data = [];
  String? errorMessage;

  Future<void> fetchProcessManage() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.processManage);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => ProcessManageModel.fromJson(e)).toList();
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

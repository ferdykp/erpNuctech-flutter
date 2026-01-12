import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/task_queue1_model.dart';

class TaskQueue1Provider extends ChangeNotifier {
  bool loading = false;
  List<TaskQueue1Model> data = [];
  String? errorMessage;

  Future<void> fetchTaskQueue1() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.taskQueue1);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => TaskQueue1Model.fromJson(e)).toList();
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

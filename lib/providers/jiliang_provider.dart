import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/jiliang_model.dart';

class JiliangProvider extends ChangeNotifier {
  bool loading = false;
  List<Jiliang> data = [];
  String? errorMessage;

  Future<void> fetchJiliang() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.jiliang);

      if (response == null || response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Jiliang.fromJson(e)).toList();
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

import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/kehuxin_model.dart';

class KehuxinProvider extends ChangeNotifier {
  bool loading = false;
  List<Kehuxin> data = [];
  String? errorMessage;

  Future<void> fetchKehuxin() async {
    try {
      loading = true;
      errorMessage = null;

      final response = await ApiClient.get(ApiConfig.kehuxin);

      if (response["data"] == null) {
        errorMessage = "Failed to load data";
        data = [];
      } else {
        List dataList = response["data"];
        data = dataList.map((e) => Kehuxin.fromJson(e)).toList();
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

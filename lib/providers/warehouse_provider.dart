// import 'package:flutter/material.dart';
// import '../models/warehouse_model.dart';
// import '../core/network/api_client.dart';

// class WarehouseProvider extends ChangeNotifier {
//   List<Warehouse> warehouses = [];
//   bool loading = false;

//   Future<void> fetchWarehouses() async {
//     loading = true;
//     notifyListeners();

//     try {
//       final response = await ApiClient.get(ApiConfig.warehouse);

//       // Response Laravel:
//       // { status:true, message:"..", data:[...] }
//       List dataList = response["data"];

//       warehouses = dataList.map((e) => Warehouse.fromJson(e)).toList();
//     } catch (e) {
//       debugPrint("ERROR API: $e");
//     }

//     loading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import '../models/warehouse_model.dart';
import '../core/network/api_client.dart';

class WarehouseProvider extends ChangeNotifier {
  List<Warehouse> warehouses = [];
  bool loading = false;

  // =================== 🆕 ADDED ===================
  String? errorMessage;
  // =================================================

  Future<void> fetchWarehouses() async {
    loading = true;
    errorMessage = null; // 🆕 reset error
    notifyListeners();

    try {
      final response = await ApiClient.get(ApiConfig.warehouse);

      if (response["data"] == null) {
        // =================== 🆕 ADDED ===================
        errorMessage = "Failed to load data";
        warehouses = [];
        // =================================================
      } else {
        List dataList = response["data"];
        warehouses = dataList.map((e) => Warehouse.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("ERROR API: $e");

      // =================== 🆕 ADDED ===================
      errorMessage = "Cannot connect to server";
      warehouses = [];
      // =================================================
    } finally {
      // =================== 🆕 FIX ===================
      loading = false;
      notifyListeners();
      // ===============================================
    }
  }
}

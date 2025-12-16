import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/network/api_client.dart';
import '../models/warehouse_model.dart';

class WarehouseService {
  Future<List<Warehouse>> getWarehouses() async {
    final response = await http.get(Uri.parse(ApiConfig.warehouse));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((w) => Warehouse.fromJson(w)).toList();
    } else {
      throw Exception("Failed to load warehouses");
    }
  }
}

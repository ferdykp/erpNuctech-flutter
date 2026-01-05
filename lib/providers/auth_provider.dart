import 'package:flutter/material.dart';
import '../core/network/api_client.dart';
import '../models/login_model.dart';

class AuthProvider extends ChangeNotifier {
  bool loading = false;
  String? errorMessage;
  LoginUser? user;

  bool get isAdmin => user?.role == "admin";

  Future<bool> login(String username, String password) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiClient.post(ApiConfig.login, {
        "username": username,
        "password": password,
      });

      final result = LoginResponse.fromJson(response);

      if (!result.status) {
        errorMessage = result.message;
        loading = false;
        notifyListeners();
        return false;
      }

      user = result.data;
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerUser({
    required String newUsername,
    required String newPassword,
    required String role,
  }) async {
    if (!isAdmin) {
      errorMessage = "Tidak punya hak akses";
      notifyListeners();
      return false;
    }

    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiClient.post(ApiConfig.register, {
        "admin_username": user!.username,
        "username": newUsername,
        "password": newPassword,
        "role": role, // ← dari dropdown
      });

      loading = false;
      notifyListeners();

      return response['status'] == true;
    } catch (e) {
      loading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}

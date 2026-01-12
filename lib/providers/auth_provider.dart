import 'dart:async';
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
      }).timeout(const Duration(seconds: 5));

      final result = LoginResponse.fromJson(response);

      /// ❌ LOGIN GAGAL (dari backend)
      if (!result.status) {
        errorMessage = result.message.isNotEmpty
            ? result.message
            : "Username atau password salah";
        loading = false;
        notifyListeners();
        return false;
      }

      /// ✅ LOGIN BERHASIL
      user = result.data;
      loading = false;
      notifyListeners();
      return true;
    }
    /// ⏱ TIMEOUT
    on TimeoutException {
      errorMessage = "Server belum aktif atau koneksi timeout";
    }
    /// 🌐 NETWORK / SERVER ERROR
    catch (e) {
      final msg = e.toString().toLowerCase();

      if (msg.contains("socket") ||
          msg.contains("connection") ||
          msg.contains("network")) {
        errorMessage = "Server Off";
      } else {
        errorMessage = "Terjadi kesalahan, silakan coba lagi";
      }
    }

    loading = false;
    notifyListeners();
    return false;
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
        "role": role,
      }).timeout(const Duration(seconds: 5));

      loading = false;
      notifyListeners();

      return response['status'] == true;
    } on TimeoutException {
      errorMessage = "Server tidak merespon (timeout)";
    } catch (e) {
      errorMessage = "Gagal mendaftarkan user";
    }

    loading = false;
    notifyListeners();
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    bool isSuccess = await AuthService.login(username, password);
    if (isSuccess) {
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception('Login failed');
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

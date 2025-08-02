class AuthService {
  static Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (username == 'admin@gmail.com' && password == 'admin@2000') {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 300));
  }
}

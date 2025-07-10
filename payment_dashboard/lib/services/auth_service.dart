import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://127.0.0.1:3000';

  /// ✅ Login
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      await _storage.write(key: 'token', value: body['access_token']);
      return true;
    }

    return false;
  }

  /// ✅ Logout
  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }

  /// ✅ Get stored token
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  /// ✅ Check if logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://127.0.0.1:3000';

  Future<List<User>> getUsers() async {
    final token = await _storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$_baseUrl/users'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((u) => User.fromJson(u)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> addUser(String username, String password, String role) async {
    final token = await _storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$_baseUrl/users'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }
}

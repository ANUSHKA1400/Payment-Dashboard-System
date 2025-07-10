import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/payment_stats.dart';
import '../models/payment.dart';

class PaymentService {
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://127.0.0.1:3000';

  /// Fetches payment statistics for dashboard
  Future<PaymentStats?> getStats() async {
    final token = await _storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('$_baseUrl/payments/stats'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return PaymentStats.fromJson(body);
    } else {
      throw Exception('Failed to load stats (${response.statusCode})');
    }
  }

  Future<List<Payment>> getAllPayments({
    String? status,
    String? method,
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 10,
  }) async {
    final token = await _storage.read(key: 'token');

    final queryParams = <String, String>{
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
    if (status != null) queryParams['status'] = status;
    if (method != null) queryParams['method'] = method;
    if (startDate != null)
      queryParams['startDate'] = startDate.toIso8601String();
    if (endDate != null) queryParams['endDate'] = endDate.toIso8601String();

    final uri = Uri.parse(
      '$_baseUrl/payments',
    ).replace(queryParameters: queryParams);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Payment.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }

  /// ✅ Creates (simulates) a new payment
  Future<void> createPayment({
    required double amount,
    required String receiver,
    required String method,
    required String status,
  }) async {
    final token = await _storage.read(key: 'token');

    final response = await http.post(
      Uri.parse('$_baseUrl/payments'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'amount': amount,
        'receiver': receiver,
        'method': method,
        'status': status,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create payment (${response.statusCode})');
    }
  }
}

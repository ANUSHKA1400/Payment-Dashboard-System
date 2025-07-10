// main.dart
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payment_dashboard/screens/user_management_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Dashboard',
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/login',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/transactions': (context) => const TransactionsScreen(),
        '/add-payment': (context) => const AddPaymentScreen(),
        '/users': (context) => const UserManagementScreen(),
      },
    );
  }
}

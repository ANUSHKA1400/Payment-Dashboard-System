import 'package:flutter/material.dart';
import '../services/payment_service.dart';
import '../models/payment_stats.dart';
import '../widgets/revenue_chart.dart';
import '../services/auth_service.dart'; // ✅ Make sure this is imported

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PaymentStats? _stats;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    final stats = await PaymentService().getStats();
    setState(() {
      _stats = stats;
      _loading = false;
    });
  }

  Future<void> _logout() async {
    await AuthService().logout();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: _logout,
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _stats == null
          ? const Center(child: Text('Failed to load stats'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildStatCard(
                    "Today's Transactions",
                    _stats!.totalToday.toString(),
                  ),
                  _buildStatCard(
                    "Total Revenue",
                    '₹${_stats!.totalRevenue.toStringAsFixed(2)}',
                  ),
                  _buildStatCard(
                    "Failed Transactions",
                    _stats!.failedCount.toString(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Weekly Revenue Trend",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: RevenueChart(
                      weeklyRevenue: [2000, 3500, 4200, 5000, 6000, 7500, 8200],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/add-payment'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Payment'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/transactions'),
                        icon: const Icon(Icons.list_alt),
                        label: const Text('Transactions'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/users'),
                        icon: const Icon(Icons.people),
                        label: const Text('Manage Users'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

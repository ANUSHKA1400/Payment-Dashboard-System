import 'package:flutter/material.dart';
import 'package:payment_dashboard/models/payment.dart';
import 'package:payment_dashboard/services/payment_service.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final PaymentService _paymentService = PaymentService();
  List<Payment> _payments = [];
  String? _selectedStatus;
  String? _selectedMethod;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isLoading = true; // For initial load and pagination loading
  String? _errorMessage; // For displaying fetch errors

  // Pagination state
  int _currentPage = 1;
  final int _pageSize = 10; // Number of items per page
  bool _hasMore = true; // Indicates if there are more pages to load
  final ScrollController _scrollController = ScrollController();

  final List<String> _statuses = ['success', 'failed', 'pending'];
  final List<String> _methods = ['card', 'upi', 'bank'];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _hasMore &&
          !_isLoading) {
        // User has scrolled to the bottom, and there's more data to load
        _currentPage++;
        _fetchTransactions(append: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchTransactions({bool append = false}) async {
    if (!append) {
      // Clear data and reset state for a fresh fetch (not appending)
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _payments = [];
        _currentPage = 1; // Reset page on new filters/refresh
        _hasMore = true; // Assume there's more until proven otherwise
      });
    } else {
      // Only show loading indicator for appending more data
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final fetchedPayments = await _paymentService.getAllPayments(
        page: _currentPage,
        pageSize: _pageSize,
        status: _selectedStatus,
        method: _selectedMethod,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
      );

      setState(() {
        _payments.addAll(fetchedPayments); // Add fetched payments to the list
        _isLoading = false;
        _hasMore =
            fetchedPayments.length ==
            _pageSize; // If less than pageSize, no more data
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load transactions: ${e.toString()}';
      });
      print('Error fetching payments: $e'); // For internal debugging
    }
  }

  void _showDetails(Payment payment) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
          children: [
            Text('ID: ${payment.id}'), // Added ID for clarity
            Text('Amount: ₹${payment.amount.toStringAsFixed(2)}'),
            Text('Method: ${payment.method}'),
            Text('Receiver: ${payment.receiver}'),
            Text('Status: ${payment.status}'),
            Text(
              'Date: ${payment.date.toLocal().toString().split('.')[0]}',
            ), // Nicer date format
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020), // Adjust as needed
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ), // Up to a year in future
      initialDateRange: _selectedStartDate != null && _selectedEndDate != null
          ? DateTimeRange(start: _selectedStartDate!, end: _selectedEndDate!)
          : null,
    );

    if (picked != null &&
        (picked.start != _selectedStartDate ||
            picked.end != _selectedEndDate)) {
      setState(() {
        _selectedStartDate = picked.start;
        _selectedEndDate = picked.end;
      });
      _fetchTransactions(); // Fetch with new date range
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedStatus = null;
      _selectedMethod = null;
      _selectedStartDate = null;
      _selectedEndDate = null;
    });
    _fetchTransactions(); // Fetch all payments without filters
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            tooltip: 'Filter by Date Range',
            onPressed: _selectDateRange,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Transactions',
            onPressed: _resetFilters, // Use reset filters for refresh action
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    hint: const Text('Filter by Status'),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Statuses'),
                      ), // Option to clear filter
                      ..._statuses.map(
                        (s) => DropdownMenuItem(value: s, child: Text(s)),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() => _selectedStatus = val);
                      _fetchTransactions();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedMethod,
                    hint: const Text('Filter by Method'),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Methods'),
                      ), // Option to clear filter
                      ..._methods.map(
                        (m) => DropdownMenuItem(value: m, child: Text(m)),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() => _selectedMethod = val);
                      _fetchTransactions();
                    },
                  ),
                ),
              ],
            ),
            if (_selectedStartDate != null || _selectedEndDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Date Range: '
                  '${_selectedStartDate?.toLocal().toString().split(' ')[0] ?? 'Start'} to '
                  '${_selectedEndDate?.toLocal().toString().split(' ')[0] ?? 'End'}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            _isLoading &&
                    _payments.isEmpty &&
                    _errorMessage ==
                        null // Show initial loading if no data yet
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage !=
                      null // Show error if present
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_errorMessage!),
                        ElevatedButton(
                          onPressed: _fetchTransactions, // Retry button
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : _payments
                      .isEmpty // Show no data message if list is empty after loading
                ? const Center(
                    child: Text('No transactions found with current filters.'),
                  )
                : Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          _payments.length +
                          (_hasMore ? 1 : 0), // Add 1 for pagination loading
                      itemBuilder: (context, index) {
                        if (index == _payments.length) {
                          return _isLoading // Only show loading at bottom if _isLoading is true (for appending)
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox.shrink(); // Hide if no more data
                        }
                        final p = _payments[index];
                        return Card(
                          elevation: 2, // Add a subtle shadow
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 0,
                          ), // Adjust margin
                          child: ListTile(
                            title: Text(
                              '₹${p.amount.toStringAsFixed(2)} - ${p.receiver}',
                            ), // Format amount
                            subtitle: Text('${p.method} | ${p.status}'),
                            trailing: Text(
                              p.date.toLocal().toString().split(
                                ' ',
                              )[0], // Nicer date format
                              style: const TextStyle(fontSize: 12),
                            ),
                            onTap: () => _showDetails(p),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/payment_service.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _receiverController = TextEditingController();
  String? _selectedMethod;
  String? _selectedStatus;

  final List<String> _methods = ['card', 'upi', 'bank'];
  final List<String> _statuses = ['success', 'failed', 'pending'];
  bool _submitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMethod == null || _selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select method and status')),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      await PaymentService().createPayment(
        amount: double.parse(_amountController.text),
        receiver: _receiverController.text,
        method: _selectedMethod!,
        status: _selectedStatus!,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment simulated successfully')),
      );
      _formKey.currentState!.reset();
      setState(() {
        _selectedMethod = null;
        _selectedStatus = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to simulate payment')),
      );
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter amount' : null,
              ),
              TextFormField(
                controller: _receiverController,
                decoration: const InputDecoration(labelText: 'Receiver'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter receiver' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedMethod,
                hint: const Text('Payment Method'),
                items: _methods
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedMethod = val),
              ),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                hint: const Text('Status'),
                items: _statuses
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedStatus = val),
              ),
              const SizedBox(height: 20),
              _submitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Simulate Payment'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

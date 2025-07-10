class Payment {
  final String id;
  final double amount;
  final String method;
  final String status;
  final String receiver;
  final DateTime date;

  Payment({
    required this.id,
    required this.amount,
    required this.method,
    required this.status,
    required this.receiver,
    required this.date,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      method: json['method'],
      status: json['status'],
      receiver: json['receiver'],
      date: DateTime.parse(json['date']),
    );
  }
}

class PaymentStats {
  final int totalToday;
  final double totalRevenue;
  final int failedCount;

  PaymentStats({
    required this.totalToday,
    required this.totalRevenue,
    required this.failedCount,
  });

  factory PaymentStats.fromJson(Map<String, dynamic> json) {
    return PaymentStats(
      totalToday: json['totalToday'],
      totalRevenue: json['totalRevenue'].toDouble(),
      failedCount: json['failedCount'],
    );
  }
}

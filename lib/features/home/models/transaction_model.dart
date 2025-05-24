class Transaction {
  final String id;
  final String type; // e.g., 'credit' or 'debit'
  final double amount;
  final String description;
  final DateTime date;
  // You could add more transaction details, e.g.,
  // final String recipientName;
  // final String senderName;
  // final String status; // e.g., 'completed', 'pending', 'failed'

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(), // Ensure it's a double
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String), // Parse ISO 8601 string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(), // Convert to ISO 8601 string
    };
  }

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, amount: $amount, description: $description, date: $date)';
  }
}

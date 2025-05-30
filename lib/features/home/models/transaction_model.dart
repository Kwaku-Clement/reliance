class Transaction {
  final String id;
  final double amount;
  final String type; // 'credit' or 'debit'
  final String description;
  final DateTime date;
  final String status; // 'pending', 'completed', 'failed'
  final String reference;
  final String? category;
  final Map<String, dynamic>? metadata;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
    required this.status,
    required this.reference,
    this.category,
    this.metadata,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'].toString(),
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] ?? 'debit',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date'] ?? json['created_at']),
      status: json['status'] ?? 'completed',
      reference: json['reference'] ?? '',
      category: json['category'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
      'reference': reference,
      'category': category,
      'metadata': metadata,
    };
  }

  bool get isCredit => type.toLowerCase() == 'credit';
  bool get isDebit => type.toLowerCase() == 'debit';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isFailed => status.toLowerCase() == 'failed';

  Transaction copyWith({
    String? id,
    double? amount,
    String? type,
    String? description,
    DateTime? date,
    String? status,
    String? reference,
    String? category,
    Map<String, dynamic>? metadata,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      category: category ?? this.category,
      metadata: metadata ?? this.metadata,
    );
  }
}

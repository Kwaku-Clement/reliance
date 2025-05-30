class Account {
  final String id;
  final String accountNumber;
  final double balance;
  final String currency;
  final String accountType;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Account({
    required this.id,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.accountType,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'].toString(),
      accountNumber: json['account_number'] ?? '',
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] ?? 'GHS',
      accountType: json['account_type'] ?? 'savings',
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_number': accountNumber,
      'balance': balance,
      'currency': currency,
      'account_type': accountType,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Account copyWith({
    String? id,
    String? accountNumber,
    double? balance,
    String? currency,
    String? accountType,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      accountType: accountType ?? this.accountType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

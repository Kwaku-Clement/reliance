class Account {
  final double balance;
  final String currency;
  // You could add more account details here, e.g.,
  // final String accountNumber;
  // final String accountType;
  // final String bankName;

  Account({required this.balance, required this.currency});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      balance: (json['balance'] as num).toDouble(), // Ensure it's a double
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'balance': balance, 'currency': currency};
  }

  @override
  String toString() {
    return 'Account(balance: $balance, currency: $currency)';
  }
}

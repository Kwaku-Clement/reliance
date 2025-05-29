class PaymentRequest {
  final double amount;
  final String currency;
  final String recipientId;
  final String? paymentGatewayToken;
  final Map<String, dynamic>? deviceInfo;
  final Map<String, dynamic>? locationInfo;

  PaymentRequest({
    required this.amount,
    required this.currency,
    required this.recipientId,
    this.paymentGatewayToken,
    this.deviceInfo,
    this.locationInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'recipient_id': recipientId,
      'payment_gateway_token': paymentGatewayToken,
      'device_info': deviceInfo,
      'location': locationInfo,
    };
  }

  @override
  String toString() {
    return 'PaymentRequest(amount: $amount, currency: $currency, recipientId: $recipientId, hasDeviceInfo: ${deviceInfo != null}, hasLocationInfo: ${locationInfo != null})';
  }
}

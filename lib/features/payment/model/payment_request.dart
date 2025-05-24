// **IMPORTANT:** Removed the incorrect 'import 'package:reliance/core/models/base_model.dart';'
// **IMPORTANT:** Changed 'implements BaseModel' to a simple class definition.

class PaymentRequest {
  final double amount;
  final String currency;
  final String recipientId;
  final String?
  paymentGatewayToken; // Optional token from a payment gateway SDK
  final Map<String, dynamic>? deviceInfo; // Sensitive data like device info
  final Map<String, dynamic>? locationInfo; // Sensitive data like location info

  PaymentRequest({
    required this.amount,
    required this.currency,
    required this.recipientId,
    this.paymentGatewayToken,
    this.deviceInfo,
    this.locationInfo,
  });

  // No @override annotation is needed here as it's not implementing an interface
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'recipient_id': recipientId,
      'payment_gateway_token': paymentGatewayToken,
      'device_info':
          deviceInfo, // This data is sent to backend for fraud/security
      'location':
          locationInfo, // This data is sent to backend for fraud/security
    };
  }

  @override
  String toString() {
    return 'PaymentRequest(amount: $amount, currency: $currency, recipientId: $recipientId, hasDeviceInfo: ${deviceInfo != null}, hasLocationInfo: ${locationInfo != null})';
  }
}

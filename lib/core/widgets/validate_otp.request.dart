class ValidateOtpRequest {
  final String phoneNumber;
  final String otp;

  ValidateOtpRequest({
    required this.phoneNumber,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber, 'otp': otp};
  }
}

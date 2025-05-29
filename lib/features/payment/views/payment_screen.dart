import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:reliance/l10n/app_localizations.dart';
import '../controllers/payment_controller.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_text_styles.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaymentController>(
        context,
        listen: false,
      ).checkBiometricsAvailability();
    });
  }

  Future<void> _handlePayment() async {
    final double? amount = double.tryParse(_amountController.text);
    final String recipient = _recipientController.text.trim();
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    final paymentController = Provider.of<PaymentController>(
      context,
      listen: false,
    );

    if (amount == null || amount <= 0) {
      _showSnackBar(
        localizations.invalidInput(localizations.amountHint),
        isError: true,
      );
      return;
    }
    if (recipient.isEmpty) {
      _showSnackBar(
        localizations.invalidInput(localizations.recipientHint),
        isError: true,
      );
      return;
    }

    // Optional: Biometric Authentication
    if (paymentController.canUseBiometrics) {
      bool authenticated = await paymentController.authenticateWithBiometrics(
        localizations.confirmPayment,
      );
      if (!authenticated) {
        _showSnackBar(localizations.biometricFailed);
        return;
      }
    } else {
      _showSnackBar(localizations.biometricNotAvailable, isError: false);
    }

    await paymentController.makePayment(amount, recipient);

    if (mounted) {
      // Localize status message based on generic message from controller
      String displayMessage = paymentController.statusMessage ?? '';
      bool isError = true;

      if (displayMessage.contains('Payment successful!')) {
        isError = false;
        // Extract transaction ID from the generic message
        final RegExp regExp = RegExp(r'Transaction ID: (.*)');
        final match = regExp.firstMatch(displayMessage);
        final transactionId = match?.group(1) ?? 'N/A';
        displayMessage = localizations.paymentSuccessful(transactionId);
      } else if (displayMessage.contains('Invalid amount.')) {
        displayMessage = localizations.invalidInput(localizations.amountHint);
      } else if (displayMessage.contains('Recipient cannot be empty.')) {
        displayMessage = localizations.invalidInput(
          localizations.recipientHint,
        );
      } else if (displayMessage.contains('Payment failed:')) {
        displayMessage = localizations.paymentFailed(
          displayMessage.replaceFirst('Payment failed: ', ''),
        );
      } else {
        displayMessage = localizations.unexpectedError;
      }

      _showSnackBar(displayMessage, isError: isError);

      if (!isError) {
        _amountController.clear();
        _recipientController.clear();
        context.pop();
      }
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final PaymentController paymentController = context
        .watch<PaymentController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.paymentScreenTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.payment,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              localizations.enterPaymentDetails,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: localizations.recipientHint,
                prefixIcon: const Icon(Icons.account_circle),
              ),
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: localizations.amountHint,
                prefixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            AppButton(
              text: localizations.confirmPayment,
              onPressed: _handlePayment,
              isLoading: paymentController.isLoading,
            ),
            const SizedBox(height: 20),
            if (paymentController.statusMessage != null)
              Text(
                // This will be localized by _showSnackBar, but we still need to show it here
                // For production, consider a dedicated status display widget that handles localization internally.
                paymentController.statusMessage!,
                style: AppTextStyles.bodyMediumLight.copyWith(
                  color:
                      paymentController.statusMessage!.contains(
                        'failed',
                      ) // Simple check for error color
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            if (!paymentController.canUseBiometrics)
              Text(
                localizations.biometricNotAvailable,
                style: AppTextStyles.bodySmallLight.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            Text(
              localizations.securityReminderBackend,
              style: AppTextStyles.bodySmallLight.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.5),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

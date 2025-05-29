import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reliance/core/utils/assets.dart';
import 'package:reliance/core/widgets/app_button.dart';
import 'package:reliance/l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Illustration image at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image.asset(
              Assets.imagesLandingPage,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Content column positioned at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14),
                  // Title and description
                  Text(
                    'Create your Reliance account',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Reliance is a powerful tool that allows you to easily send, receive, and track all your transactions.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: AppButton(
                      text: AppLocalizations.of(context)!.signUp,
                      type: AppButtonType.primary,
                      onPressed: () {
                        // Navigate to sign-up page
                        context.pushNamed('register');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: AppButton(
                      text: AppLocalizations.of(context)!.signIn,
                      type: AppButtonType.outline,
                      onPressed: () {
                        // Navigate to sign-in page
                        context.pushNamed('login');
                      },
                    ),
                  ),

                  SizedBox(height: 20),

                  // Terms and Privacy
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(text: 'By continuing you accept our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

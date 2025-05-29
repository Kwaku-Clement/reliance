import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart';

/// Provides the AuthViewModel to the widget tree.
class AuthProvider extends StatelessWidget {
  final Widget child;

  const AuthProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      // Create AuthViewModel using GetIt to inject its dependencies
      create: (_) => GetIt.I.get<AuthViewModel>(),
      child: child,
    );
  }
}

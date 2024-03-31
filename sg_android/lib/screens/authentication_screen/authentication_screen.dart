// authentication_screen.dart

import 'package:flutter/material.dart';
import 'package:sg_android/screens/authentication_screen/components/login_form.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: LoginPage(), // Include the login form component
      ),
    );
  }
}

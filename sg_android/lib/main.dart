import 'package:flutter/material.dart';
import 'package:sg_android/screens/authentication_screen/components/login_form.dart'; // Import your login page
import 'package:sg_android/screens/home_screen/home_screen.dart'; // Import your home screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // Set the initial route to login page
      routes: {
        '/login': (context) => LoginPage(),
        // Define routes for login page
        '/home': (context) => HomeScreen(),
        // Define routes for home screen
      },
    );
  }
}

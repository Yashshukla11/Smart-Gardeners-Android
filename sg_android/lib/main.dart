import 'package:flutter/material.dart';
import 'package:sg_android/screens/authentication_screen/components/login_form.dart'; // Import your login page
import 'package:sg_android/screens/home_screen/home_screen.dart';
import 'package:sg_android/screens/contact/contact.dart';
import 'package:sg_android/screens/user_dashboard_screen/user_dashboard_screen.dart';
import 'package:sg_android/screens/user_dashboard_screen/profile.dart'; // Import the UserDashboard widget

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
        '/dashboard': (context) => const UserDashboardScreen(),
        // Define route for user dashboard screen
        '/profile': (context) => const ProfileScreen(),
        // Define route for profile screen
        '/contact': (context) => const ContactScreen(),
        // Define route for contact screen
      },
    );
  }
}

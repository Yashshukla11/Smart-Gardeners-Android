import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:sg_android/screens/authentication_screen/components/login_form.dart';
import 'package:sg_android/screens/contact/contact.dart';
import 'package:sg_android/screens/home_screen/home_screen.dart';
import 'package:sg_android/screens/user_dashboard_screen/profile.dart';
import 'package:sg_android/screens/user_dashboard_screen/user_dashboard_screen.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      // Provide an instance of HomeController
      child: MaterialApp(
        title: 'Your App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomeScreen(),
          '/dashboard': (context) => UserDashboardScreen(
                purchasedItems: [],
              ),
          '/profile': (context) => ProfileScreen(),
          '/contact': (context) => ContactScreen(),
        },
      ),
    );
  }
}

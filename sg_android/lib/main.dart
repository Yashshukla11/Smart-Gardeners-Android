import 'dart:io'; // Import for using exit()
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_android/screens/authentication_screen/components/login_form.dart';
import 'package:sg_android/screens/authentication_screen/components/signup_form.dart';
import 'package:sg_android/screens/contact/contact.dart';
import 'package:sg_android/screens/home_screen/home_screen.dart';
import 'package:sg_android/screens/user_dashboard_screen/profile.dart';
import 'package:sg_android/screens/user_dashboard_screen/user_dashboard_screen.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';
import 'package:sg_android/services/api_service.dart'; // Import ApiService
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sg_android/utils/constants.dart';
import 'package:sg_android/screens/user_dashboard_screen/components/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
              ),
              const SizedBox(
                width: 10.0, // Adjust as needed
                height: 10.0, // Adjust as needed
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor, // Set border color
                    width: 3.0, // Set border width
                  ),
                  shape: BoxShape
                      .circle, // Set shape to circle if you want a circular border
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://i.postimg.cc/xCnKqhx9/Screenshot-2024-01-22-at-2-43-19-PM-fotor-bg-remover-20240122151630.png',

                    height: 150,
                    width: 150, // Make sure the image covers the container
                  ),
                ),
              ), // Replace with your logo path
            ],
          ); // Or any loading indicator
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<Map<String, dynamic>?>(
              future: ApiService.fetchDataWithToken('user/get'),
              // Check if user exists
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      const SizedBox(
                        width: 10.0, // Adjust as needed
                        height: 10.0, // Adjust as needed
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor, // Set border color
                            width: 3.0, // Set border width
                          ),
                          shape: BoxShape.circle,

                          // Set shape to circle if you want a circular border
                        ),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.postimg.cc/xCnKqhx9/Screenshot-2024-01-22-at-2-43-19-PM-fotor-bg-remover-20240122151630.png',

                            height: 150,
                            width:
                                150, // Make sure the image covers the container
                          ),
                        ),
                      ), // Replace with your logo path
                    ],
                  );
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    // User exists, navigate to home screen
                    return ChangeNotifierProvider(
                      create: (context) => HomeController(),
                      child: MaterialApp(
                        title: 'Your App',
                        theme: ThemeData(
                          primarySwatch: Colors.teal,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                        ),
                        home: HomeScreen(),
                        routes: {
                          '/login': (context) => LoginPage(),
                          '/signup': (context) => SignupPage(),
                          '/home': (context) => HomeScreen(),
                          '/dashboard': (context) => Consumer<HomeController>(
                                builder: (context, homeController, _) =>
                                    UserDashboardScreen(
                                  purchasedItems:
                                      homeController.purchasedProducts,
                                ),
                              ),
                          '/profile': (context) => ProfileScreen(),
                          '/contact': (context) => ContactScreen(),
                          '/map': (context) => MapPage(),
                        },
                      ),
                    );
                  } else {
                    // User does not exist, navigate to login page
                    return ChangeNotifierProvider(
                      create: (context) => HomeController(),
                      child: MaterialApp(
                        title: 'Your App',
                        theme: ThemeData(
                          primarySwatch: Colors.teal,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                        ),
                        home: LoginPage(),
                        routes: {
                          '/login': (context) => LoginPage(),
                          '/signup': (context) => SignupPage(),
                          '/home': (context) => HomeScreen(),
                          '/dashboard': (context) => Consumer<HomeController>(
                                builder: (context, homeController, _) =>
                                    UserDashboardScreen(
                                  purchasedItems:
                                      homeController.purchasedProducts,
                                ),
                              ),
                          '/profile': (context) => ProfileScreen(),
                          '/contact': (context) => ContactScreen(),
                          '/map': (context) => MapPage(),
                        },
                      ),
                    );
                  }
                }
              },
            );
          } else {
            return ChangeNotifierProvider(
              create: (context) => HomeController(),
              child: MaterialApp(
                title: 'Your App',
                theme: ThemeData(
                  primarySwatch: Colors.teal,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: SignupPage(), // Navigate to SignUpPage
                // Add routes for other screens if needed
                routes: {
                  '/home': (context) => HomeScreen(),
                  '/dashboard': (context) => Consumer<HomeController>(
                        builder: (context, homeController, _) =>
                            UserDashboardScreen(
                          purchasedItems: homeController.purchasedProducts,
                        ),
                      ),
                  '/profile': (context) => ProfileScreen(),
                  '/contact': (context) => ContactScreen(),
                  '/login': (context) => LoginPage(),
                  '/map': (context) => MapPage(),
                },
              ),
            );
          }
        }
      },
    );
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginToken = prefs.getString('token');
    String? signupToken = prefs.getString('signup_token');

    // Return signupToken if it exists, otherwise return loginToken
    if (signupToken != null) {
      return signupToken;
    } else {
      return loginToken;
    }
  }
}

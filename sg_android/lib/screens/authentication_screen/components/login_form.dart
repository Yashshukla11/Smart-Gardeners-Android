import 'package:flutter/material.dart';
import 'package:sg_android/screens/home_screen/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'signup_form.dart'; // Import the SignupPage
import 'package:sg_android/services/api_service.dart'; // Import the ApiService
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  void _signIn(BuildContext context) async {
    // Retrieve email and password from controllers
    String email = _emailController.text;
    String password = _passwordController.text;

    // Create a map containing email and password
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    // Make a request to the login API
    Map<String, dynamic>? response = await ApiService.login(data);

    // Check if the response is successful
    if (response != null) {
      // Store the token locally
      String token = response['token'];
      await _storeToken(token);

      // Navigate to the home page if authentication is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Handle authentication failure, such as displaying an error message
      // For now, let's print an error message
      print('Authentication failed');
    }
  }

  Future<void> _storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://i.postimg.cc/xCnKqhx9/Screenshot-2024-01-22-at-2-43-19-PM-fotor-bg-remover-20240122151630.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Column(
                  children: [
                    Text(
                      'Smart Gardeners',
                      style: TextStyle(
                        color: Color(0xFF66BB69),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'You have been missed',
                      style: TextStyle(
                        color: Color(0xFF66BB69),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF66BB69)),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'yourmail@gmail.com',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.mail,
                            color: Color(0xFF66BB69),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          // Handle email input
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF66BB69)),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: 'XXXX',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Color(0xFF66BB69),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          // Handle password input
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          _signIn(context); // Call the _signIn function
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF66BB69),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the signup page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: const Text('Not a Member? Register Now'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

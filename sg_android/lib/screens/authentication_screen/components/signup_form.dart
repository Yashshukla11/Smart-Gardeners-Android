import 'package:flutter/material.dart';
import 'package:sg_android/screens/home_screen/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'login_form.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignupPage({super.key});

  void _signUp(BuildContext context) {
    // Perform your custom sign-up logic here
    // For demonstration purposes, let's navigate to the home page directly
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
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
                      'Join us to start your gardening journey',
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person,
                            color: Color(0xFF66BB69),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle name input
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
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
                          hintText: 'Enter your password',
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
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          hintText: 'Confirm your password',
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
                          _signUp(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF66BB69),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign Up',
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text('Already a Member? Log In Now'),
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

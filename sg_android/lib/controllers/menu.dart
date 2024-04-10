import 'package:flutter/material.dart';
import 'package:sg_android/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.account_circle,
              size: 50,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "User Name",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            width: 100,
            child: Divider(color: Colors.white),
          ),
          Text(
            "Start Gardening",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final Function(String) onMenuItemSelected;

  const Menu({Key? key, required this.onMenuItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const MyHeaderDrawer(),
            _buildMenuItem('Dashboard', Icons.dashboard, context),
            _buildMenuItem('Shop', Icons.shopping_cart, context),
            _buildMenuItem('User Profile', Icons.person, context),
            _buildMenuItem('Contact Us', Icons.contact_phone, context),
            _buildMenuItem('Log Out', Icons.exit_to_app, context),
            const Divider(
              color: kPrimaryColor,
              height: 0,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  color: Colors.white,
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://i.postimg.cc/xCnKqhx9/Screenshot-2024-01-22-at-2-43-19-PM-fotor-bg-remover-20240122151630.png',
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                '© 2024 Smart Gardeners. All rights reserved.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData iconData, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'Log Out') {
          _logout(context);
        } else {
          _navigateToScreen(context, title);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: kPrimaryColor,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String title) {
    switch (title) {
      case 'Dashboard':
        Navigator.pushNamed(context, '/dashboard');
        break;
      case 'Shop':
        Navigator.pushNamed(context, '/home');
        break;
      case 'User Profile':
        Navigator.pushNamed(context, '/profile');
        break;
      case 'Contact Us':
        Navigator.pushNamed(context, '/contact');
        break;
      default:
        break;
    }
  }

  Future<void> _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Delete the token
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}

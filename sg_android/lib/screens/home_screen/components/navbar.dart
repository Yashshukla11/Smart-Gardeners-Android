import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onNotificationPressed;

  const CustomNavBar({
    Key? key,
    required this.onMenuPressed,
    required this.onNotificationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // Set background color
      // Set background color
      title: const Text(
        "Smart Gardeners",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF66BB69), // Set text color to white
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.menu_rounded,
          color: Color(0xFF66BB69), // Set icon color to white
        ),
        onPressed: onMenuPressed,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Color(0xFF66BB69), // Set icon color to white
          ),
          onPressed: onNotificationPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

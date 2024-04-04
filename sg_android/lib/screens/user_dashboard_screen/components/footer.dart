import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Rounded border
          border: Border.all(color: Colors.black),
          gradient: const LinearGradient(
            colors: [Color(0xffffeeee), Color(0xffddefbb)],
            stops: [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )

          // Border color
          ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // Circular border
            ),
            child: IconButton(
              icon: const Icon(
                Icons.account_circle,
                size: 30,
                color: Color(0xFF66BB69),
              ),
              onPressed: () {
                // Add onPressed action for profile icon
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 60, // Adjust the width as needed
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Circular border
                    border: Border.all(color: Color(0xff061161)),
                    gradient: const LinearGradient(
                      colors: [Color(0xff870000), Color(0xff190a05)],
                      stops: [0, 1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )

                    // Border color
                    ),
                child: IconButton(
                  icon: const Icon(
                    Icons.qr_code_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  // Adjust size of QR icon
                  onPressed: () {
                    // Add onPressed action for QR scanner
                  },
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // Circular border
              // Border color
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Color(0xFF66BB69),
              ),
              onPressed: () {
                // Add onPressed action for cart icon
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; // Import flutter_barcode_scanner package
import 'package:sg_android/services/api_service.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key? key}) : super(key: key);

  // Function to handle QR code scanning and product ID extraction
  Future<void> scanQRAndSendRequest(BuildContext context) async {
    try {
      // Scan QR code
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      // Check if a barcode (product ID) is received from the QR scanner
      if (barcodeScanRes != '-1') {
        String productId = barcodeScanRes;

        // Call updateCycleStage function to send data to server
        await ApiService.updateCycleStage(productId);

        // Show success message or perform any other action
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cycle stage updated successfully!'),
          ),
        );
      } else {
        // Show error message if no barcode is received
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to scan QR code or extract product ID!'),
          ),
        );
      }
    } catch (error) {
      // Show error message if any error occurs during scanning or API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
        gradient: const LinearGradient(
          colors: [Color(0xffffeeee), Color(0xffddefbb)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
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
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xff061161)),
                  gradient: const LinearGradient(
                    colors: [Color(0xff870000), Color(0xff190a05)],
                    stops: [0, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.qr_code_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Trigger QR code scanning and sending request
                    scanQRAndSendRequest(context);
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF66BB69),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                  // You can add additional actions related to the IconButton here if needed
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

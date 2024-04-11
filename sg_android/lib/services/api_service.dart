import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';

class ApiService {
  static const String baseUrl = 'http://13.201.130.101:8000';

  static Future<Map<String, dynamic>?> register(
      Map<String, dynamic> data) async {
    var url = Uri.parse('$baseUrl/user/register');
    try {
      debugPrint('Sending registration request to: $url');
      final response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Failed to register: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception during registration: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> login(Map<String, dynamic> data) async {
    var url = Uri.parse('$baseUrl/user/login');
    try {
      final response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Failed to login: ${response}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception during login: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchDataWithToken(
      String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      debugPrint('No token found.');
      return null;
    }

    var url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body) as Map<String, dynamic>;
        // Extract user ID from the response and store it
        String? userId = responseData['_id'];
        if (userId != null) {
          // Store user ID in SharedPreferences
          await prefs.setString('userId', userId);
        }
        // Print the fetched data and user ID
        // print('Fetched data: $responseData');
        // print('User ID: $userId');
        // Return the fetched data along with the user ID
        return {'userData': responseData, 'userId': userId};
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception during data fetch: $e');
      return null;
    }
  }

  static Future<void> getProductDetails() async {
    var url = Uri.parse('$baseUrl/product');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List<dynamic>;

        // Clear the demoProducts list
        demoProducts.clear();

        // Loop through the JSON data and populate the demoProducts list
        for (var item in jsonData) {
          Product product = Product(
            id: item['_id'],
            title: item['title'],
            subCategory: item['subCategory'],
            description: item['description'],
            image: item['image'],
            price: item['price'],
          );
          demoProducts.add(product);
        }
      } else {
        debugPrint('Failed to fetch product details: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error fetching product details: $error');
    }
  }

  static Future<bool> payNow(List<ProductItem> cart) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (userId == null) {
      debugPrint('No user ID found.');
      return false; // Indicate failure
    }

    // Construct the cart data in the required format
    List<Map<String, dynamic>> cartData = [];
    for (var item in cart) {
      cartData.add({
        'productId': item.product?.id,
        'quantity': item.quantity,
      });
    }

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'userId': userId,
      'cart': cartData,
    };

    // Send the POST request
    var url = Uri.parse('$baseUrl/product/purchase');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint('Payment successful!');
        return true; // Indicate success
      } else {
        debugPrint('Payment failed: ${response.statusCode}');
        return false; // Indicate failure
      }
    } catch (e) {
      debugPrint('Error during payment: $e');
      return false; // Indicate failure
    }
  }

  static Future<void> getpurchasedProductDetails(
      HomeController homeController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      debugPrint('No token found.');
      return; // Exit the function if token is not found
    }

    var url = Uri.parse('$baseUrl/user/purchased');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // debugPrint('Fetched purchased product details: ${response.body}');
        var jsonData = jsonDecode(response.body) as List<dynamic>;

        // Clear the purchasedProducts list before populating
        homeController.purchasedProducts.clear();

        // Loop through the JSON data and populate the purchasedProducts list
        for (var item in jsonData) {
          if (item['product'] != null) {
            PurchasedProduct purchasedProduct = PurchasedProduct(
              id: item['_id'],
              title: item['product']['title'],
              subCategory: item['product']['subCategory'],
              description: item['product']['description'],
              image: item['product']['image'],
              price: item['product']['price'],
              cycleStage: item['cycleStage'],
              purchaseDate: item['purchaseDate'],
              plantedDate: item['plantedDate'] ??
                  "null", // Provide a default value if plantedDate is null
            );
            homeController.purchasedProducts.add(purchasedProduct);
          }
        }
        // Notify listeners after updating purchasedProducts list
        homeController.notifyListeners();
      } else {
        debugPrint(
            'Failed to fetch purchased product details: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error fetching purchased product details: $error');
    }
  }

  static Future<void> updateCycleStage(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      debugPrint('No token found.');
      return; // Exit the function if token is not found
    }

    var url = Uri.parse('$baseUrl/user/scan');

    // Print the data before sending
    debugPrint('Sending update cycle stage request: Product ID - $productId');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set content type to JSON
        },
        body: jsonEncode({
          'productId': productId,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Cycle stage updated successfully!');
      } else {
        debugPrint('Failed to update cycle stage: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error updating cycle stage: $error');
    }
  }
}

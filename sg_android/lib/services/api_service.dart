import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sg_android/model/product.dart';

class ApiService {
  static const String baseUrl = 'https://smart-gardeners-j1xc.onrender.com';

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
        return jsonDecode(response.body);
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
}

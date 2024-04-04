import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:sg_android/model/product.dart';

class GardeningController extends ChangeNotifier {
  List<ProductItem> cart = [];
  List<String> purchasedItems = [];

  void storeCart() {
    if (kDebugMode) {
      print('Storing cart information...');
    }
    // Clear the previous list of purchased items
    purchasedItems.clear();
    // Add titles of purchased items to the list
    for (var item in cart) {
      purchasedItems.add(item.product.title);
    }
    // Notify listeners if needed
    notifyListeners();
  }

  void addToCart(Product product) {
    for (ProductItem item in cart) {
      if (item.product.title == product.title) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(ProductItem(product: product));
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}

class ProductItem {
  int quantity;
  final Product product;

  ProductItem({this.quantity = 1, required this.product});

  void increment() {
    quantity++;
  }

  void add(int amount) {
    quantity += amount;
  }

  void subtract(int amount) {
    if (quantity - amount > 0) {
      quantity -= amount;
    } else {
      quantity = 0;
    }
  }
}

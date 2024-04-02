import 'package:flutter/foundation.dart';
import 'package:sg_android/model/product.dart';

class ProductPurchased extends ChangeNotifier {
  List<String> _cartItems = [];

  // Getter to access cart items
  List<String> get cartItems => _cartItems;

  // Function to add item to cart
  void addItemToCart(String item) {
    _cartItems.add(item);
    notifyListeners(); // Notify listeners about the change
  }

  // Function to remove item from cart
  void removeItemFromCart(String item) {
    _cartItems.remove(item);
    notifyListeners(); // Notify listeners about the change
  }

  // Function to get purchased products based on cart items
  List<Product> getPurchasedProducts() {
    // Replace the implementation below with logic to fetch product details based on cart items
    return demoProducts
        .where((product) => _cartItems.contains(product.title))
        .toList();
  }
}

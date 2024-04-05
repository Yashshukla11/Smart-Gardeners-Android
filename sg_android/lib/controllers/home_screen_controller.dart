import 'package:flutter/foundation.dart';
import 'package:sg_android/model/product.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;

  List<ProductItem> cart = [];

  List<String> purchasedItems = [];

  void changeHomeState(HomeState state) {
    homeState = state;
    notifyListeners();
  }

  void addProductToCart(Product product) {
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

    print('Cleared Cart. Purchased Items: $purchasedItems');
    notifyListeners();
  }

  int get totalCartItems {
    int total = 0;
    for (var item in cart) {
      total += item.quantity;
    }
    return total;
  }

  void storeCart() {
    if (kDebugMode) {
      print('Storing cart information...');
    }

    // Clear the previous list of purchased items
    purchasedItems.clear();
    // Add titles of purchased items to the list based on quantity
    for (var item in cart) {
      for (int i = 0; i < item.quantity; i++) {
        purchasedItems.add(item.product.title);
      }
    }
    // Notify listeners if needed
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

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/services/api_service.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;

  List<ProductItem> cart = [];
  List<PurchasedProduct> purchasedProducts = [];
  List<Product> _products = [];

  List<Product> get products => _products;

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

    notifyListeners();
  }

  int get totalCartItems {
    int total = 0;
    for (var item in cart) {
      total += item.quantity;
    }
    return total;
  }

  // Removed storeCart and generateUniqueCode functions

  // Removed printPurchasedProductDetails function

  Future<void> getProductDetails() async {
    // Call the ApiService function to fetch product details
    await ApiService.getProductDetails();

    // After fetching, update the products list
    _products = demoProducts;

    // Print the updated products list

    // Notify listeners after updating the products list
    notifyListeners();
  }

  Future<void> getpurchasedProductDetails() async {
    await ApiService.getpurchasedProductDetails(this);
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

class PurchasedProduct {
  final String id; // Add _id field
  final String title;
  final String subCategory;
  final String description;
  final String image;
  final int price;
  final int cycleStage;
  final String purchaseDate;
  final String plantedDate;

  PurchasedProduct({
    required this.id, // Include _id in the constructor
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.subCategory,
    required this.cycleStage,
    required this.purchaseDate,
    required this.plantedDate,
  });
}

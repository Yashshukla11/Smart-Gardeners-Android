import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_android/model/product.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;

  List<ProductItem> cart = [];
  List<PurchasedProduct> _purchasedProducts = [];

  List<PurchasedProduct> get purchasedProducts => _purchasedProducts;

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
    
    print('Cleared Cart. Purchased Products: $_purchasedProducts');
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
    for (var item in cart) {
      for (int i = 0; i < item.quantity; i++) {
        Product productDetails = demoProducts
            .firstWhere((product) => product.title == item.product.title);

        PurchasedProduct purchasedProduct = PurchasedProduct(
          title: productDetails.title,
          subcategory: productDetails.subcategory,
          description: productDetails.description,
          image: productDetails.image,
          price: productDetails.price,
          uniqueCode: generateUniqueCode(productDetails.title),
        );

        _purchasedProducts.add(purchasedProduct);

        printPurchasedProductDetails(purchasedProduct);
      }
    }

    notifyListeners();
  }

  String generateUniqueCode(String title) {
    final random = Random();
    final suffix = random.nextInt(999999).toString().padLeft(6, '0');
    return '$title-$suffix';
  }

  void printPurchasedProductDetails(PurchasedProduct purchasedProduct) {
    print('Purchased Product:');
    print('Title: ${purchasedProduct.title}');
    print('Subcategory: ${purchasedProduct.subcategory}');
    print('Description: ${purchasedProduct.description}');
    print('Image URL: ${purchasedProduct.image}');
    print('Price: ${purchasedProduct.price}');
    print('Unique Code: ${purchasedProduct.uniqueCode}');
    print('-----------------------------------------');
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
  final String title;
  final String subcategory;
  final String description;
  final String image;
  final int price;
  final String uniqueCode;

  PurchasedProduct({
    required this.title,
    required this.subcategory,
    required this.description,
    required this.image,
    required this.price,
    required this.uniqueCode,
  });
}

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/services/api_service.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;

  List<ProductItem> cart = [];
  List<PurchasedProduct> _purchasedProducts = [];
  List<Product> _products = [];

  List<PurchasedProduct> get purchasedProducts => _purchasedProducts;

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
        Product productDetails = _products
            .firstWhere((product) => product.title == item.product.title);

        PurchasedProduct purchasedProduct = PurchasedProduct(
          title: productDetails.title,
          subCategory: productDetails.subCategory,
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
    print('subCategory: ${purchasedProduct.subCategory}');
    print('Description: ${purchasedProduct.description}');
    print('Image URL: ${purchasedProduct.image}');
    print('Price: ${purchasedProduct.price}');
    print('Unique Code: ${purchasedProduct.uniqueCode}');
    print('-----------------------------------------');
  }

  Future<void> getProductDetails() async {
    // Call the ApiService function to fetch product details
    await ApiService.getProductDetails();

    // After fetching, update the products list
    _products = demoProducts;

    // Print the updated products list
    print('Updated products: $_products');

    // Notify listeners after updating the products list
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

class PurchasedProduct {
  final String title;
  final String subCategory;
  final String description;
  final String image;
  final int price;
  final String uniqueCode;

  PurchasedProduct({
    required this.title,
    required this.subCategory,
    required this.description,
    required this.image,
    required this.price,
    required this.uniqueCode,
  });
}

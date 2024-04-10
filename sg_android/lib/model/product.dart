class Product {
  final String title;
  final String subCategory;
  final String description;
  final String image;
  final int price;

  Product({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.subCategory,
  });
}

class ProductItem {
  int quantity;
  final Product? product;

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

List<Product> demoProducts = [];

class Product {
  final String id; // Add _id field
  final String title;
  final String subCategory;
  final String description;
  final String image;
  final int price;

  Product({
    required this.id, // Include _id in the constructor
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.subCategory,
  });
}

class Productss {
  int quantity;
  final Product? product;

  Productss({this.quantity = 1, required this.product});

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

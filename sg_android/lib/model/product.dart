class Product {
  final String title;
  final String image;

  Product({required this.title, required this.image});
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

List<Product> demoProducts = [
  Product(
      title: "Full Kit", image: "https://i.postimg.cc/L86fdwCP/fanal-kit.png"),
  Product(
      title: "Coco Coir",
      image: "https://i.postimg.cc/Bvf0P9rL/final-coir.png"),
  Product(
      title: "Seed Pack",
      image: "https://i.postimg.cc/rm82gGFq/Final-Seed.png"),
  Product(
      title: "Nutrient Pack",
      image: "https://i.postimg.cc/SRP0ywLK/Final-Nureients.png"),
  Product(
      title: "Mother Cups",
      image: "https://i.postimg.cc/YqJcTBqn/final-cup.png"),
  Product(
      title: "Mother Tray",
      image: "https://i.postimg.cc/zfF9LLw6/final-tray.png"),
  Product(
      title: "Mother Cups",
      image: "https://i.postimg.cc/YqJcTBqn/final-cup.png"),
];

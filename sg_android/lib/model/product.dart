class Product {
  final String title;
  final String subcategory;
  final String description;
  final String image;
  final int price;

  Product(this.title,
      {required this.price,
      required this.description,
      required this.image,
      required this.subcategory});
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
  Product("Full Kit",
      subcategory: "Kit",
      description: "Full kit for growing plants",
      price: 1000,
      image: "https://i.postimg.cc/L86fdwCP/fanal-kit.png"),
  Product("Coco Coir",
      subcategory: "Kit",
      description: "Coco coir for plants",
      price: 50,
      image: "https://i.postimg.cc/Bvf0P9rL/final-coir.png"),
  Product("Seed Pack",
      subcategory: "Friut",
      description: "Seed pack for plants",
      price: 100,
      image: "https://i.postimg.cc/rm82gGFq/Final-Seed.png"),
  Product("Nutrient Pack",
      subcategory: "Fruit",
      description: "Nutrient pack for plants",
      price: 200,
      image: "https://i.postimg.cc/SRP0ywLK/Final-Nureients.png"),
  Product("Mother Cups",
      subcategory: "Kit",
      description: "Mother cups for plants",
      price: 40,
      image: "https://i.postimg.cc/YqJcTBqn/final-cup.png"),
  Product("Mother Tray",
      subcategory: "Kit",
      description: "Mother tray for plants",
      price: 80,
      image: "https://i.postimg.cc/zfF9LLw6/final-tray.png"),
];

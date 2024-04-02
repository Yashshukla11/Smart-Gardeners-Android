import 'package:flutter/material.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/screens/home_screen/deatils/components/cart_counter.dart';
import 'package:sg_android/screens/home_screen/components/fav_btn.dart';
import 'package:sg_android/screens/home_screen/components/price.dart';
import 'package:sg_android/utils/constants.dart';
import 'package:sg_android/model/product_purchased.dart'; // Import ProductPurchased class

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
    required this.onProductAdd,
  }) : super(key: key);

  final Product product;
  final VoidCallback onProductAdd;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _cartTag = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding, // Add some space to the bottom
            ),
            child: ElevatedButton(
              onPressed: () {
                // Call the function to add item to cart and pass the product title
                ProductPurchased().addItemToCart(widget.product.title);
                widget.onProductAdd();
                setState(() {
                  _cartTag = '_cartTag';
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF66BB69), // Change button color
              ),
              child: const Text("Add to Cart",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.37,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: kBackgroundColor,
                    child: Hero(
                      tag: widget.product.title + _cartTag,
                      child: Image.network(widget.product.image),
                    ),
                  ),
                  const Positioned(
                    bottom: -20,
                    child: CartCounter(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Price(amount: widget.product.price.toStringAsFixed(2)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text(
                widget.product.description,
                style: const TextStyle(
                  color: Color(0xFFBDBDBD),
                  height: 1.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: const BackButton(
        color: Colors.white,
      ),
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Smart Gardeners",
        style: TextStyle(color: Colors.white),
      ),
      actions: const [
        SizedBox(width: kDefaultPadding),
      ],
    );
  }
}

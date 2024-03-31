import 'package:flutter/material.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/screens/home_screen/deatils/details.dart';
import 'package:sg_android/screens/home_screen/components/fav_btn.dart';
import 'package:sg_android/screens/home_screen/components/price.dart';
import 'package:sg_android/utils/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  final Product product;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: GestureDetector(
          onTap: press,
          child: Container(
            padding: const EdgeInsets.all(defaultPadding / 4),
            decoration: const BoxDecoration(
              color: kCardBackgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(kDefaultPadding * 1.25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Hero(
                      tag: product.title,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Divider(color: Colors.grey), // Add spacing
                Text(
                  product.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Fruits",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Price(amount: "20.00"),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // Invoke the same functionality as onPressed
                    press();
                    // setState(() {
                    //   _cartTag = '_cartTag';
                    // });
                    // Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(kDefaultPadding / 4),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

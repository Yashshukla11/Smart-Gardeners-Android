import 'package:flutter/material.dart';
import 'package:sg_android/model/product.dart';
import 'package:sg_android/screens/home_screen/deatils/details.dart';
import 'package:sg_android/screens/home_screen/components/price.dart';
import 'package:sg_android/utils/constants.dart';

import '../../../model/product_purchased.dart';

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
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding / 2),
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
            SizedBox(
              height: 20,
              child: Text(
                product.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            Text(
              product.subCategory,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Price(amount: product.price.toStringAsFixed(1)),
                const SizedBox(width: 30),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                ProductPurchased().addItemToCart(product.title);
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Explore",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

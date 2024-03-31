import 'package:flutter/material.dart';
import 'package:sg_android/controllers/home_screen_controller.dart'; // Import the correct controller
import 'package:sg_android/utils/constants.dart'; // Update with your actual project name
import 'package:sg_android/screens/home_screen/components/price.dart'; // Update with your actual project name
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage package

class CartDetailsViewCard extends StatelessWidget {
  const CartDetailsViewCard({
    Key? key,
    required this.productItem,
  }) : super(key: key);

  final ProductItem
      productItem; // Ensure that this ProductItem refers to the correct class

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        backgroundImage: CachedNetworkImageProvider(
            productItem.product.image), // Use CachedNetworkImageProvider
      ),
      title: Text(
        productItem.product.title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            const Price(amount: "20"),
            // You may need to pass the actual price here
            Text(
              "  x ${productItem.quantity}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

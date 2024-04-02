import 'package:flutter/material.dart';
import 'package:sg_android/controllers/home_screen_controller.dart'
    as Controller;
import 'package:sg_android/model/product.dart' as Model;
import 'package:sg_android/screens/home_screen/components/price.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/constants.dart';

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({Key? key, required this.controller}) : super(key: key);

  final Controller.HomeController controller;

  @override
  Widget build(BuildContext context) {
    // Calculate total amount
    double totalAmount = 0.0;
    for (var item in controller.cart) {
      totalAmount += item.product.price * item.quantity;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
              child: Text("Cart",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 30))),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.cart.length,
            itemBuilder: (context, index) {
              final Controller.ProductItem productItem = controller.cart[index];
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        CachedNetworkImageProvider(productItem.product.image),
                  ),
                ),
                title: Text(
                  productItem.product.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                trailing: FittedBox(
                  child: Row(
                    children: [
                      Price(
                          amount:
                              (productItem.product.price * productItem.quantity)
                                  .toStringAsFixed(2)),
                      Text(
                        "  x ${productItem.quantity}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16), // Add appropriate spacing here
          const Divider(
            color: kPrimaryColor,
          ), // Add a divider
          const SizedBox(height: 16), // Add spacing after the divider
          Center(
            child: Text(
              "Total: Rs ${totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
            ),
          ),
          const SizedBox(height: 16), // Add spacing after the total
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                onPressed: () {},
                child: const Text("Pay Now",
                    style: TextStyle(color: Colors.white)),
              )),
        ],
      ),
    );
  }
}

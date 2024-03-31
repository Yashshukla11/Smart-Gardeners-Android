import 'package:flutter/material.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';
import 'cart_detailsview_card.dart';

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cart", style: Theme.of(context).textTheme.titleLarge),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.cart.length,
            itemBuilder: (context, index) {
              return CartDetailsViewCard(productItem: controller.cart[index]);
            },
          ),
          const SizedBox(height: 16), // Add appropriate spacing here
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Next - ${controller.totalCartItems()}"),
            ),
          ),
        ],
      ),
    );
  }
}

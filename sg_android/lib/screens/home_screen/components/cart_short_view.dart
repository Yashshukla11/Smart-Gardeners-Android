import 'package:flutter/material.dart';
import 'package:sg_android/controllers/home_screen_controller.dart';
import 'package:sg_android/utils/constants.dart';

class CartShortView extends StatelessWidget {
  const CartShortView({
    Key? key,
    required this.controller,
    required Color cartColor,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Cart",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
        ),
        const SizedBox(width: kDefaultPadding),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.cart.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding / 2),
                  child: Hero(
                      tag: "${controller.cart[index].product.title}_cartTag",
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF66BB69),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            controller.cart[index].product.image,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Text(
            controller.totalCartItems().toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:sg_android/utils/constants.dart';
import 'rounded_icon_button.dart'; // Importing the necessary file

class CartCounter extends StatelessWidget {
  const CartCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Row(
        children: [
          RoundIconBtn(
            // Corrected the name to RoundIconBtn
            iconData: Icons.remove,
            color: kTextColor.withOpacity(0.4),
            press: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 4),
            child: Text(
              "1",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ),
          RoundIconBtn(
            // Corrected the name to RoundIconBtn
            iconData: Icons.add,
            press: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    this.radius = 12,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFFFFFFF),
      child: Icon(
        Icons.favorite,
        color: Colors.red, // Adjust color as needed
        size: radius * 2, // Adjust size as needed
      ),
    );
  }
}

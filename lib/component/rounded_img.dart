import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class Rounded_Img extends StatelessWidget {
  const Rounded_Img({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
              "assets/images/shop_logo.png"), //NetworkImage('Path to your image'),
        ),
        borderRadius: defaultBorderRadius,
      ),
    );
  }
}

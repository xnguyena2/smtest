import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class TextUnderlineCustome extends StatelessWidget {
  const TextUnderlineCustome({
    super.key,
    required this.totalPriceFormat,
  });

  final String totalPriceFormat;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Text(
          totalPriceFormat,
          style: headStyleXLargehightUnderline.copyWith(
            decorationColor: Colors.white,
          ),
        ),
        Positioned(
          bottom: -5,
          child: Text(
            totalPriceFormat,
            style: headStyleXLargehightUnderline.copyWith(
              color: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }
}

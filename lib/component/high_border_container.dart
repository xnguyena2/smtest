import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class HighBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool isHight;
  const HighBorderContainer(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(12),
      this.isHight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
        border: isHight ? tableHighBorder : lightBorder,
      ),
      child: child,
    );
  }
}

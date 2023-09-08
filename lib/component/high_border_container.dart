import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class HighBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const HighBorderContainer(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(12)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
        border: tableHighBorder,
      ),
      child: child,
    );
  }
}

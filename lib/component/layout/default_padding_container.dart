import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class DefaultPaddingContainer extends StatelessWidget {
  final Widget child;
  const DefaultPaddingContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/simple_switch_btn.dart';
import 'package:sales_management/utils/constants.dart';

class SwitchCircleBtn extends StatelessWidget {
  final bool isDisable;
  const SwitchCircleBtn({
    super.key,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleSwitchBtn(
      isDisable: isDisable,
      padding: EdgeInsets.all(4),
      backGroundWidget: Container(
        width: 45,
        height: 22,
      ),
      onSelected: (bool) {},
      selectedWidget: [
        CircleAvatar(
          radius: 11,
          backgroundColor: White,
        ),
        CircleAvatar(
          radius: 11,
          backgroundColor: TableHighColor,
        )
      ],
      borderRadius: BorderRadius.circular(20),
      backgroundColor: Black15,
    );
  }
}

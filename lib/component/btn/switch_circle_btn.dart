import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/simple_switch_btn.dart';
import 'package:sales_management/utils/constants.dart';

class SwitchCircleBtn extends StatelessWidget {
  const SwitchCircleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleSwitchBtn(
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
          backgroundColor: HighColor,
        )
      ],
      borderRadius: BorderRadius.circular(20),
      backgroundColor: Black15,
    );
  }
}

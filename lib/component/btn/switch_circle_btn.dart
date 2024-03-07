import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/simple_switch_btn.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class SwitchCircleBtn extends StatelessWidget {
  final bool initStatus;
  final VoidCallbackArg<bool> onChange;
  const SwitchCircleBtn({
    super.key,
    this.initStatus = false,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleSwitchBtn(
      isDisable: false,
      selectedIndex: initStatus ? 1 : 0,
      padding: const EdgeInsets.all(4),
      backGroundWidget: const SizedBox(
        width: 45,
        height: 22,
      ),
      onSelected: onChange,
      selectedWidget: const [
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

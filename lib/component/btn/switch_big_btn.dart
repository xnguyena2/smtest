import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/simple_switch_btn.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class SwitchBigBtn extends StatelessWidget {
  final String firstTxt;
  final String secondTxt;
  final bool isDisable;
  final int selectedIndex;
  final VoidCallbackArg<bool> onChanged;
  const SwitchBigBtn({
    super.key,
    required this.firstTxt,
    required this.secondTxt,
    this.isDisable = false,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleSwitchBtn(
      selectedIndex: selectedIndex,
      isDisable: isDisable,
      backGroundWidget: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 9),
            child: Text(
              firstTxt,
              style: headStyleBigMediumBlackLight,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 9),
            child: Text(
              secondTxt,
              style: headStyleBigMediumBlackLight,
            ),
          )
        ],
      ),
      onSelected: onChanged,
      selectedWidget: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
              color: White,
              border: alertBorder,
              borderRadius: defaultSquareBorderRadius,
              boxShadow: [defaultShadow]),
          child: Text(
            firstTxt,
            style: headStyleLargeAlert,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
              color: White,
              border: tableHighBorder,
              borderRadius: defaultSquareBorderRadius,
              boxShadow: [defaultShadow]),
          child: Text(
            secondTxt,
            style: headStyleBigMediumHigh,
          ),
        ),
      ],
      borderRadius: defaultSquareBorderRadius,
    );
  }
}

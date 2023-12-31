import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/simple_switch_btn.dart';
import 'package:sales_management/utils/constants.dart';

class SwitchBtn extends StatelessWidget {
  final String firstTxt;
  final String secondTxt;
  const SwitchBtn({
    super.key,
    required this.firstTxt,
    required this.secondTxt,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleSwitchBtn(
      backGroundWidget: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              firstTxt,
              style: subInfoStyLargeLight500,
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              secondTxt,
              style: subInfoStyLargeLight500,
            ),
          )
        ],
      ),
      onSelected: (bool) {},
      selectedWidget: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: White,
              borderRadius: defaultSquareBorderRadius,
              boxShadow: [defaultShadow]),
          child: Text(
            firstTxt,
            style: subInfoStyLarge500High,
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: White,
              borderRadius: defaultSquareBorderRadius,
              boxShadow: [defaultShadow]),
          child: Text(
            secondTxt,
            style: subInfoStyLarge500High,
          ),
        ),
      ],
      borderRadius: defaultSquareBorderRadius,
    );
  }
}

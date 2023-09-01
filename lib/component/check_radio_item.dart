import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class CheckRadioItem extends StatelessWidget {
  final bool isCheck;
  final String txt;
  const CheckRadioItem({
    super.key,
    required this.isCheck,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          padding: EdgeInsets.all(2),
          decoration: ShapeDecoration(
            color: White,
            shape: CircleBorder(
              side: BorderSide(
                width: 1,
                color: isCheck ? HighColor : borderColor,
              ),
            ),
          ),
          child: isCheck
              ? CircleAvatar(
                  backgroundColor: HighColor,
                )
              : SizedBox(),
        ),
        SizedBox(
          width: 11,
        ),
        Text(
          txt,
          style: headStyleBigMedium,
        ),
      ],
    );
  }
}

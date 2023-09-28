import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class CheckRadioItem<T> extends StatelessWidget {
  final void Function(T?) onChanged;
  final T? groupValue;
  final T value;
  final String txt;
  const CheckRadioItem({
    super.key,
    required this.txt,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            padding: EdgeInsets.all(2),
            // decoration: ShapeDecoration(
            //   color: White,
            //   shape: CircleBorder(
            //     side: BorderSide(
            //       width: 1,
            //       color: groupValue == value ? HighColor : borderColor,
            //     ),
            //   ),
            // ),
            child: Radio<T>(
                groupValue: groupValue,
                value: value,
                onChanged: onChanged,
                fillColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return HighColor;
                  }
                  return borderColor;
                })),
          ),
          SizedBox(
            width: 11,
          ),
          Text(
            txt,
            style: headStyleBigMedium,
          ),
        ],
      ),
    );
  }
}

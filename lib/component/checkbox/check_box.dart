import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class SmallCheckBox extends StatefulWidget {
  const SmallCheckBox(
      {super.key, required this.isChecked, required this.onChanged});

  final bool isChecked;
  final VoidCallbackArg<bool> onChanged;

  @override
  State<SmallCheckBox> createState() => _SmallCheckBoxState();
}

class _SmallCheckBoxState extends State<SmallCheckBox> {
  late bool isChecked = widget.isChecked;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      width: 24.0,
      child: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith((states) {
          const Set<MaterialState> interactiveStates = <MaterialState>{
            MaterialState.selected,
          };
          if (states.any(interactiveStates.contains)) {
            return TableHighColor;
          }
          return White;
        }),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            widget.onChanged(isChecked);
          });
        },
      ),
    );
  }
}

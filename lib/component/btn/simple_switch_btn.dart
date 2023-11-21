import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class SimpleSwitchBtn extends StatefulWidget {
  final Widget backGroundWidget;
  final List<Widget> selectedWidget;
  final VoidCallbackArg<bool> onSelected;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final bool isDisable;
  final int selectedIndex;
  const SimpleSwitchBtn({
    super.key,
    required this.backGroundWidget,
    required this.onSelected,
    required this.selectedWidget,
    required this.borderRadius,
    this.padding,
    this.backgroundColor = BackgroundColor,
    this.isDisable = false,
    this.selectedIndex = 0,
  });

  @override
  State<SimpleSwitchBtn> createState() => _SimpleSwitchBtnState();
}

class _SimpleSwitchBtnState extends State<SimpleSwitchBtn> {
  late Widget currentSelected;
  late EdgeInsetsGeometry padding;
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSelected = widget.selectedWidget[widget.selectedIndex];
    padding = widget.padding == null ? EdgeInsets.all(2) : widget.padding!;
    isSelected = widget.selectedIndex == 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDisable
          ? null
          : () {
              setState(() {
                isSelected = !isSelected;
                currentSelected = widget.selectedWidget[isSelected ? 1 : 0];
                widget.onSelected(isSelected);
              });
            },
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            color: widget.backgroundColor, borderRadius: widget.borderRadius),
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.backGroundWidget,
            Positioned(
              left: isSelected ? null : 0,
              right: isSelected ? 0 : null,
              child: currentSelected,
            )
          ],
        ),
      ),
    );
  }
}

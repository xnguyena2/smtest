import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class SwitchBtn extends StatefulWidget {
  final String firstTxt;
  final String secondTxt;
  const SwitchBtn({
    super.key,
    required this.firstTxt,
    required this.secondTxt,
  });

  @override
  State<SwitchBtn> createState() => _SwitchBtnState();
}

class _SwitchBtnState extends State<SwitchBtn> {
  String currentSelected = '';
  bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSelected = widget.firstTxt;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          currentSelected = isSelected ? widget.secondTxt : widget.firstTxt;
        });
      },
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: BackgroundColor, borderRadius: defaultSquareBorderRadius),
        child: Stack(children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.firstTxt,
                  style: subInfoStyLargeLight500,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.secondTxt,
                  style: subInfoStyLargeLight500,
                ),
              )
            ],
          ),
          Positioned(
              left: isSelected ? null : 0,
              right: isSelected ? 0 : null,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: White,
                    borderRadius: defaultSquareBorderRadius,
                    boxShadow: [defaultShadow]),
                child: Text(
                  currentSelected,
                  style: subInfoStyLarge500High,
                ),
              ))
        ]),
      ),
    );
  }
}

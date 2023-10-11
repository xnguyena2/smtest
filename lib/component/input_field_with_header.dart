import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class InputFiledWithHeader extends StatefulWidget {
  final String header;
  final bool isImportance;
  final String hint;
  final bool isDropDown;
  final VoidCallback? onSelected;
  final String? initValue;
  final VoidCallbackArg<String>? onChanged;
  const InputFiledWithHeader({
    super.key,
    required this.header,
    required this.hint,
    this.isImportance = false,
    this.isDropDown = false,
    this.onSelected,
    this.initValue,
    this.onChanged,
  });

  @override
  State<InputFiledWithHeader> createState() => _InputFiledWithHeaderState();
}

class _InputFiledWithHeaderState extends State<InputFiledWithHeader> {
  late bool isError;
  late final TextEditingController myController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isError = widget.initValue?.isEmpty ?? true;
    myController = TextEditingController(text: widget.initValue);
    myController.addListener(() {
      final text = myController.text;

      isError = text.isEmpty;
      widget.onChanged?.call(text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.header,
                    style: widget.isImportance && isError
                        ? headStyleLargeAlert
                        : headStyleBigMedium,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (widget.isImportance)
                    Text(
                      '*',
                      style: headStyleSemiLargeAlert500,
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: widget.isImportance && isError ? Red : Black40),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: myController,
                        maxLines: 1,
                        style: customerNameBig400,
                        readOnly: widget.isDropDown,
                        onTap: widget.onSelected,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          border: InputBorder.none,
                          hintStyle: customerNameBigLight400,
                          hintText: widget.hint,
                        ),
                      ),
                    ),
                    if (widget.isDropDown)
                      LoadSvg(assetPath: 'svg/down_arrow_backup_2.svg'),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

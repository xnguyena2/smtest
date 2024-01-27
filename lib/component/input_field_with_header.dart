import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final bool isNumberOnly;
  final bool isAutoFocus;
  final bool isMoneyFormat;
  final bool isDisable;
  final bool showClose;
  const InputFiledWithHeader({
    super.key,
    required this.header,
    required this.hint,
    this.isImportance = false,
    this.isDropDown = false,
    this.onSelected,
    this.initValue,
    this.onChanged,
    this.isNumberOnly = false,
    this.isAutoFocus = false,
    this.isMoneyFormat = false,
    this.isDisable = false,
    this.showClose = true,
  });

  @override
  State<InputFiledWithHeader> createState() => _InputFiledWithHeaderState();
}

class _InputFiledWithHeaderState extends State<InputFiledWithHeader> {
  late bool isError;
  late TextEditingController txtControler =
      TextEditingController(text: widget.initValue);
  final FocusNode txtFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isError = widget.initValue?.isEmpty ?? true;
    if (widget.isNumberOnly && widget.isMoneyFormat) {
      double number = double.tryParse(txtControler.text) ?? 0;
      txtControler.text = MoneyFormater.format(number);
      txtFocus.addListener(onSelection);
    }
  }

  void onSelection() {
    if (txtFocus.hasFocus) {
      txtControler.selection = TextSelection.fromPosition(
        TextPosition(
          offset: txtControler.text.length,
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtControler.dispose();
    txtFocus.dispose();
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
                      child: widget.isDropDown
                          ? GestureDetector(
                              onTap: widget.onSelected,
                              child: Text(
                                widget.initValue ?? '',
                                style: customerNameBig400,
                              ),
                            )
                          : TextFormField(
                              focusNode: txtFocus,
                              controller: txtControler,
                              enabled: !widget.isDisable,
                              autofocus: widget.isAutoFocus,
                              onTapOutside: (event) {
                                txtFocus.unfocus();
                              },
                              keyboardType: widget.isNumberOnly
                                  ? TextInputType.number
                                  : null,
                              inputFormatters: widget.isNumberOnly
                                  ? [
                                      FilteringTextInputFormatter.digitsOnly,
                                      if (widget.isMoneyFormat)
                                        CurrencyInputFormatter()
                                    ]
                                  : null,
                              onChanged: (text) {
                                isError = text.isEmpty;
                                String txt = text;
                                if (widget.isNumberOnly &&
                                    widget.isMoneyFormat) {
                                  txt = text.replaceAll(',', '');
                                }
                                widget.onChanged?.call(txt);
                                setState(() {});
                              },
                              maxLines: 1,
                              style: customerNameBig400,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                border: InputBorder.none,
                                hintStyle: customerNameBigLight400,
                                hintText: widget.hint,
                                suffixIconConstraints: BoxConstraints(
                                  maxWidth: 20,
                                  maxHeight: 20,
                                ),
                                suffixIcon: widget.showClose && !isError
                                    ? GestureDetector(
                                        onTap: () {
                                          txtControler.text = '';
                                          isError = true;
                                          txtFocus.requestFocus();
                                          widget.onChanged?.call('');
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: LoadSvg(
                                              assetPath:
                                                  'svg/close_circle.svg'),
                                        ),
                                      )
                                    : null,
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

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    // final int selectionIndexFromTheRight =
    //     newValue.text.length - newValue.selection.end;

    // print(newValue.text);
    double value = double.tryParse(newValue.text) ?? 0;
    // print(selectionIndexFromTheRight);

    final formatter = MoneyFormater;

    String newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: new TextSelection.collapsed(offset: newText.length),
    );
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      var value = newValue.text;
      if (newValue.text.length > 2) {
        value = value.replaceAll(RegExp(r'\D'), '');
        value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
        print("Value ---- $value");
      }
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(
            offset: value.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

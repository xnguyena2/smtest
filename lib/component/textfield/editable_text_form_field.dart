import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_management/utils/svg_loader.dart';

class EditAbleTextFormField extends StatelessWidget {
  final TextAlign textAlign;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final TextStyle? style;
  final InputDecoration? decoration;
  final TapRegionCallback? onTapOutside;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  const EditAbleTextFormField({
    super.key,
    this.textAlign = TextAlign.start,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines,
    this.style,
    this.decoration,
    this.onTapOutside,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            textAlign: textAlign,
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            style: style,
            decoration: decoration,
            onTapOutside: onTapOutside ??
                (event) {
                  focusNode?.unfocus();
                },
            onChanged: onChanged,
          ),
        ),
        GestureDetector(
          onTap: () => focusNode?.requestFocus(),
          child: LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg'),
        )
      ],
    );
  }
}

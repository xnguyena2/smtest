import 'package:flutter/material.dart';
import 'package:sales_management/utils/typedef.dart';

import '../utils/constants.dart';
import '../utils/svg_loader.dart';

class AppSearchBar extends StatefulWidget {
  final String hint;
  final VoidCallbackArg<String>? onChanged;
  const AppSearchBar({
    super.key,
    required this.hint,
    this.onChanged,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  bool showCloseBtn = false;
  final editorCtr = TextEditingController();
  final searchFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    editorCtr.addListener(() {
      final text = editorCtr.text;
      widget.onChanged?.call(text);
      showCloseBtn = text.isNotEmpty;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    editorCtr.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: searchBackgroundColor,
        borderRadius: defaultBorderRadius,
        border: defaultBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 25,
          ),
          LoadSvg(assetPath: 'svg/search.svg'),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: editorCtr,
              focusNode: searchFocusNode,
              maxLines: 1,
              style: headStyleSemiLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: widget.hint,
              ),
            ),
          ),
          if (showCloseBtn)
            GestureDetector(
              onTap: () {
                editorCtr.clear();
                searchFocusNode.requestFocus();
              },
              child: LoadSvg(assetPath: 'svg/close_circle.svg'),
            ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

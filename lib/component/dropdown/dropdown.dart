import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class DropDownCustome extends StatefulWidget {
  final List<String> list;
  final VoidCallbackArg<String> onChanged;
  const DropDownCustome(
      {super.key, required this.list, required this.onChanged});

  @override
  State<DropDownCustome> createState() => _DropDownCustomeState();
}

class _DropDownCustomeState extends State<DropDownCustome> {
  late String dropdownValue = widget.list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        items: widget.list
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: subInfoStyLarge600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: dropdownValue,
        onChanged: (value) {
          if (value == null) {
            return;
          }
          dropdownValue = value;
          widget.onChanged(value);
          setState(() {});
        },
        buttonStyleData: ButtonStyleData(
          height: 30,
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: defaultBorderRadius,
            border: tableHighBorder,
            color: White,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          iconSize: 14,
          iconEnabledColor: TableHighColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: defaultBorderRadius,
            color: White,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

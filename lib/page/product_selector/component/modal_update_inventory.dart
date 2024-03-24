import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ModalUpdateInventory extends StatefulWidget {
  final int inventoryNum;
  final VoidCallbackArg<int> onDone;
  const ModalUpdateInventory({
    super.key,
    required this.inventoryNum,
    required this.onDone,
  });

  @override
  State<ModalUpdateInventory> createState() => _ModalUpdateInventoryState();
}

class _ModalUpdateInventoryState extends State<ModalUpdateInventory> {
  bool isActiveOk = false;
  late int inventory_number = widget.inventoryNum;
  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Chỉnh sửa tồn kho',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: InputFiledWithHeader(
              isNumberOnly: true,
              isMoneyFormat: true,
              header: 'Tồn kho',
              hint: 'Sổ lượng tồn kho',
              initValue: MoneyFormater.format(inventory_number),
              isImportance: false,
              onChanged: (value) {
                inventory_number = tryParseNumber(value);
                isActiveOk = inventory_number > 0;
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {
              Navigator.pop(context);
              widget.onDone(inventory_number);
            },
            cancel: () {
              Navigator.pop(context);
            },
            okBtnTxt: 'Cập nhật',
            isActiveOk: isActiveOk,
          ),
        ],
      ),
    );
  }
}

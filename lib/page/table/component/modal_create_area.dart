import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/component/modal_base.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalCreateArea extends StatefulWidget {
  final AreaData area;
  final VoidCallbackArg<AreaData> onDone;
  const ModalCreateArea({
    super.key,
    required this.area,
    required this.onDone,
  });

  @override
  State<ModalCreateArea> createState() => _ModalCreateAreaState();
}

class _ModalCreateAreaState extends State<ModalCreateArea> {
  bool isActiveOk = false;
  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Tạo khu vực',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: InputFiledWithHeader(
              initValue: widget.area.areaName,
              header: 'Tên khu vực',
              hint: 'Nhập tên khu vực',
              isImportance: true,
              onChanged: (areaName) {
                isActiveOk = areaName.isNotEmpty;
                widget.area.areaName = areaName;
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
              widget.onDone(widget.area);
            },
            cancel: () {
              Navigator.pop(context);
            },
            okBtnTxt: 'Tạo',
            isActiveOk: isActiveOk,
          ),
        ],
      ),
    );
  }
}

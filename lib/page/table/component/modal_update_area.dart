import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/component/modal_base.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalUpdateArea extends StatefulWidget {
  final AreaData area;
  final VoidCallbackArg<AreaData> onDone;
  final VoidCallbackArg<AreaData> onDeleteArea;
  const ModalUpdateArea({
    super.key,
    required this.area,
    required this.onDone,
    required this.onDeleteArea,
  });

  @override
  State<ModalUpdateArea> createState() => _ModalUpdateAreaState();
}

class _ModalUpdateAreaState extends State<ModalUpdateArea> {
  bool isActiveOk = false;
  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Chỉnh sửa tên khu vực',
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
            enableDelete: true,
            done: () {
              Navigator.pop(context);
              widget.onDone(widget.area);
            },
            cancel: () {
              Navigator.pop(context);
              showDefaultDialog(
                context,
                'Xác nhận xóa!',
                'Bạn có chắc muốn xóa?',
                onOk: () {
                  widget.onDeleteArea(widget.area);
                },
                onCancel: () {},
              );
            },
            okBtnTxt: 'Cập nhật',
            isActiveOk: isActiveOk,
          ),
        ],
      ),
    );
  }
}

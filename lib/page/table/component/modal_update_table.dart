import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalUpdateTable extends StatefulWidget {
  final TableDetailData table;
  final VoidCallbackArg<TableDetailData> onDone;
  final VoidCallbackArg<TableDetailData> onDeleteTable;
  const ModalUpdateTable({
    super.key,
    required this.table,
    required this.onDone,
    required this.onDeleteTable,
  });

  @override
  State<ModalUpdateTable> createState() => _ModalUpdateTableState();
}

class _ModalUpdateTableState extends State<ModalUpdateTable> {
  bool isActiveOk = false;
  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Chỉnh sửa tên bàn',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: InputFiledWithHeader(
              initValue: widget.table.tableName,
              header: 'Tên bàn',
              hint: 'Nhập tên bàn',
              isImportance: true,
              onChanged: (table) {
                isActiveOk = table.isNotEmpty;
                widget.table.tableName = table;
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
              widget.onDone(widget.table);
            },
            cancel: () {
              Navigator.pop(context);
              showDefaultDialog(
                context,
                'Xác nhận xóa!',
                'Bạn có chắc muốn xóa?',
                onOk: () {
                  widget.onDeleteTable(widget.table);
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

import 'package:flutter/material.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/page/table/component/modal_update_table.dart';
import 'package:sales_management/page/table/table_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class TableItem extends StatefulWidget {
  final VoidCallbackArg<TableDetailData> successDeleteTableData;
  final TableDetailData tableDetailData;
  final onTableSelected done;
  final bool isEditting;
  final bool isSelectingForOrder;
  const TableItem({
    super.key,
    required this.tableDetailData,
    required this.done,
    required this.isEditting,
    required this.successDeleteTableData,
    required this.isSelectingForOrder,
  });

  @override
  State<TableItem> createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  late TableDetailData tableDetailData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tableDetailData = widget.tableDetailData;
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = tableDetailData.isUsed;
    String timeElasped = tableDetailData.timeElapsed;
    return GestureDetector(
      onTap: () {
        if (widget.isEditting) {
          return;
        }
        if (widget.isSelectingForOrder && tableDetailData.isUsed) {
          return;
        }
        widget.done(tableDetailData);
        Navigator.pop(context);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: BackgroundColorLigh,
          borderRadius: defaultBorderRadius,
          border: isSelected ? tableHighBorder : defaultBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              color: isSelected ? TableHighBGColor : TableHeaderBGColor,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                overflow: TextOverflow.ellipsis,
                tableDetailData.tableName ?? 'unknow',
                style: isSelected ? headStyleMediumNormaWhite : headStyleMedium,
              ),
            ),
            if (isSelected)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LoadSvg(assetPath: 'svg/time_filled.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            timeElasped,
                            style: subInfoStyLargeTable400,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LoadSvg(assetPath: 'svg/money_alt.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            MoneyFormater.format(tableDetailData.price),
                            style: subInfoStyLargeTable400,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (!isSelected && widget.isEditting)
              Expanded(
                child: UnconstrainedBox(
                  child: GestureDetector(
                    onTap: () => showDefaultModal(
                      context: context,
                      content: ModalUpdateTable(
                        table: tableDetailData.clone(),
                        onDone: (table) {
                          createTable(table).then((value) {
                            tableDetailData = value;
                            showNotification(
                                context, 'Cập nhật thành công!');
                            setState(() {});
                          }).onError(
                            (error, stackTrace) {
                              showAlert(context, 'Không thể cập nhật!');
                            },
                          );
                        },
                        onDeleteTable: (table) {
                          deleteTable(table)
                              .then((value) =>
                                  widget.successDeleteTableData(value))
                              .onError((error, stackTrace) =>
                                  showAlert(context, 'Không thể xóa!'));
                        },
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: defaultBorderRadius,
                          border: tableHighBorder),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg'),
                              SizedBox(
                                width: 1,
                              ),
                              const Text(
                                'Chỉnh sửa',
                                style: subInfoStyLargeTable400,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (!isSelected && !widget.isEditting)
              Expanded(
                child: Center(
                  child: LoadSvg(assetPath: 'svg/table_filled.svg'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/page/table/component/modal_update_area.dart';
import 'package:sales_management/page/table/component/table_add_new_table.dart';
import 'package:sales_management/page/table/component/table_table_item.dart';
import 'package:sales_management/page/table/table_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class TableArea extends StatefulWidget {
  final AreaData data;
  final onTableSelected done;
  final bool isEditting;
  final VoidCallbackArg<TableDetailData> successNewTable;
  final VoidCallbackArg<AreaData> successNewListTable;
  final VoidCallbackArg<AreaData> successNewUpdateAreaData;
  final VoidCallbackArg<AreaData> successDeleteAreaData;
  const TableArea({
    super.key,
    required this.data,
    required this.done,
    required this.isEditting,
    required this.successNewTable,
    required this.successNewListTable,
    required this.successNewUpdateAreaData,
    required this.successDeleteAreaData,
  });

  @override
  State<TableArea> createState() => _TableAreaState();
}

class _TableAreaState extends State<TableArea> {
  @override
  Widget build(BuildContext context) {
    var (_, avaliable) = widget.data.getStatus;
    List<TableDetailData> listTable = widget.data.listTable ?? [];
    int tableNo = listTable.length;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  widget.data.areaName ?? 'unknow',
                  style: headStyleMedium,
                ),
                if (widget.isEditting) ...[
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                      onTap: () => showDefaultModal(
                            context: context,
                            content: ModalUpdateArea(
                              area: widget.data.clone(),
                              onDone: (areaData) {
                                updateAreaData(areaData)
                                    .then(
                                      (value) => widget
                                          .successNewUpdateAreaData(value),
                                    )
                                    .onError(
                                      (error, stackTrace) => showAlert(
                                          context, 'Không thể cập nhật!'),
                                    );
                              },
                              onDeleteArea: (areaData) {
                                deleteAreaData(areaData)
                                    .then((value) =>
                                        widget.successDeleteAreaData(value))
                                    .onError((error, stackTrace) =>
                                        showAlert(context, 'Không thể xóa!'));
                              },
                            ),
                          ),
                      child: LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg')),
                ]
              ],
            ),
            Text('$avaliable còn trống', style: headStyleMediumNormalLight),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: White,
            border: defaultBorder,
            borderRadius: defaultBorderRadius,
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 12 / 10,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: tableNo + 1,
            itemBuilder: (context, index) {
              if (index == tableNo) {
                return AddNewTable(
                  data: widget.data,
                  successNewTable: widget.successNewTable,
                  successNewListTable: widget.successNewListTable,
                );
              }
              return TableItem(
                key: ObjectKey(listTable[index]),
                tableDetailData: listTable[index],
                done: (table) {
                  table.detail = widget.data.areaName;
                  widget.done(table);
                },
                isEditting: widget.isEditting,
                successDeleteTableData: (tableDetailData) {
                  widget.data.removeTable(tableDetailData);
                  showNotification(context, 'Xóa thành công!');
                  setState(() {});
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

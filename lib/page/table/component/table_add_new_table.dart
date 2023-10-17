import 'package:flutter/material.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/page/table/component/modal_create_table.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class AddNewTable extends StatelessWidget {
  final VoidCallbackArg<TableDetailData> successNewTable;
  final VoidCallbackArg<AreaData> successNewListTable;
  final AreaData data;
  const AddNewTable({
    super.key,
    required this.data,
    required this.successNewTable,
    required this.successNewListTable,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDefaultModal(
          context: context,
          content: ModalCreateTable(
            area: data,
            onDone: (newTable) {
              createTable(newTable)
                  .then((value) => successNewTable(value))
                  .onError((error, stackTrace) =>
                      showAlert(context, 'Không thể tạo bàn!'));
            },
            onDoneListTable: (areaData) {
              createListTable(areaData)
                  .then((value) => successNewListTable(value))
                  .onError((error, stackTrace) =>
                      showAlert(context, 'Không thể tạo bàn!'));
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: BackgroundColor,
          borderRadius: defaultBorderRadius,
          border: defaultBorder,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadSvg(
              assetPath: 'svg/plus.svg',
              color: MainHighColor,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Thêm bàn mới',
              style: subInfoStyLargeHigh400,
            ),
          ],
        ),
      ),
    );
  }
}

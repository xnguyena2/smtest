import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/component/app_search_bar.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/storage_provider.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalSelectArea extends StatelessWidget {
  final AreaData selectedArea;
  final VoidCallbackArg<AreaData> onDone;
  const ModalSelectArea({
    super.key,
    required this.selectedArea,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    List<AreaData> listAreaData =
        context.read<StorageProvider>().listAreaData ?? [];
    return ModalBase(
      headerTxt: 'Khu vực',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: const AppSearchBar(
                hint: 'Tìm tên khu vực',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: listAreaData.map((item) {
                bool isSelected = selectedArea.areaId == item.areaId;
                return GestureDetector(
                  onTap: () {
                    onDone(item);
                    Navigator.pop(context);
                  },
                  child: HighBorderContainer(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                    child: Text(
                      item.areaName ?? 'unknow',
                      style: isSelected
                          ? headStyleSemiLargeHigh500
                          : headStyleSemiLargeLigh500,
                    ),
                    isHight: isSelected,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

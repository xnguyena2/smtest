import 'package:flutter/material.dart';
import 'package:sales_management/component/category_selector.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/component/table_area.dart';
import 'package:sales_management/page/table/component/table_status.dart';
import 'package:sales_management/page/table/table_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';

class TableBody extends StatefulWidget {
  final onTableSelected done;
  final ListAreDataResult data;
  final VoidCallback createNewArea;
  final isEditting;
  const TableBody({
    super.key,
    required this.data,
    required this.done,
    required this.isEditting,
    required this.createNewArea,
  });

  @override
  State<TableBody> createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  List<AreaData> _foundArea = [];
  String _selectedArea = '';

  late List<AreaData> listAreaData;
  late List<String> listArea;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListArea();
  }

  void getListArea() {
    listAreaData = widget.data.listResult;
    _foundArea = listAreaData;
    listArea = (<String>['Tất cả']);
    listArea.addAll(widget.data.getListAreName);
    _selectedArea = listArea[0];
  }

  @override
  Widget build(BuildContext context) {
    if (listAreaData.isEmpty) {
      return Center(
        child: GestureDetector(
          onTap: widget.createNewArea,
          child: HighBorderContainer(
            isHight: true,
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadSvg(assetPath: 'svg/plus_large.svg'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Tạo khu vực',
                  style: headStyleSemiLargeHigh500,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: BackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableStatus(
              data: widget.data,
            ),
            const SizedBox(
              height: 10,
            ),
            CategorySelector(
              listCategory: listArea,
              onChanged: (listAreaSelected) {
                final String? area = listAreaSelected.firstOrNull;
                if (area == null || area == 'Tất cả') {
                  _foundArea = listAreaData;
                  _selectedArea = 'Tất cả';
                  setState(() {});
                  return;
                }
                _foundArea = listAreaData
                    .where((element) => element.areaName == area)
                    .toList();
                _selectedArea = area;
                setState(() {});
              },
              itemsSelected: [_selectedArea],
              isFlip: false,
              firstWidget: LoadSvg(assetPath: 'svg/grid_horizontal.svg'),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TableArea(
                    data: _foundArea[index],
                    done: widget.done,
                    isEditting: widget.isEditting,
                    successNewTable: (newTable) {
                      final area = listAreaData.firstWhere(
                        (element) => element.areaId == newTable.areaId,
                        orElse: () => AreaData(
                            id: 0,
                            groupId: '',
                            createat: '',
                            areaId: '',
                            listTable: []),
                      );
                      if (area.areaId.isNotEmpty) {
                        area.addNewTable(newTable);
                        showNotification(context, 'Thêm bàn thành công!');
                        setState(() {});
                      }
                    },
                    successNewListTable: (areaData) {
                      final area = listAreaData.firstWhere(
                        (element) => element.areaId == areaData.areaId,
                        orElse: () => AreaData(
                            id: 0,
                            groupId: '',
                            createat: '',
                            areaId: '',
                            listTable: []),
                      );
                      if (area.areaId.isNotEmpty) {
                        areaData.listTable?.forEach((newTable) {
                          area.addNewTable(newTable);
                        });
                        showNotification(context, 'Thêm bàn thành công!');
                        setState(() {});
                      }
                    },
                    successNewUpdateAreaData: (areaData) {
                      int foundIndex = listAreaData.indexWhere(
                          (element) => element.areaId == areaData.areaId);
                      if (foundIndex >= 0) {
                        listAreaData[foundIndex].areaName = areaData.areaName;
                        getListArea();
                      }
                      showNotification(context, 'Cập nhật thành công!');
                      setState(() {});
                    },
                    successDeleteAreaData: (areaData) {
                      int foundIndex = widget.data.listResult.indexWhere(
                          (element) => element.areaId == areaData.areaId);
                      if (foundIndex >= 0) {
                        widget.data.listResult.removeAt(foundIndex);
                        getListArea();
                      }
                      showNotification(context, 'Xóa thành công!');
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: _foundArea.length),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

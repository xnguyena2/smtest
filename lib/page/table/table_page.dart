import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../component/category_selector.dart';
import '../../utils/constants.dart';
import 'component/table_selector_bar.dart';

typedef onTableSelected = VoidCallbackArg<TableDetailData>;

class TablePage extends StatefulWidget {
  final VoidCallbackArg<TableDetailData> done;
  const TablePage({super.key, required this.done});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  bool isEditting = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TableSelectorBar(
          onBackPressed: () {
            if (isEditting) {
              isEditting = false;
              setState(() {});
              return;
            }
            Navigator.pop(context);
          },
          onEditting: isEditting,
          onEdit: () {
            isEditting = true;
            setState(() {});
          },
        ),
        body: FetchAPI<ListAreDataResult>(
          future: getAllTable(groupID),
          successBuilder: (data) {
            return Body(
              data: data,
              done: widget.done,
            );
          },
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final onTableSelected done;
  final ListAreDataResult data;
  const Body({
    super.key,
    required this.data,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    List<AreaData> listAreaData = data.listResult;
    List<String> listArea = (<String>['Tất cả']);
    listArea.addAll(data.getListAreName);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: BackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Status(
            data: data,
          ),
          SizedBox(
            height: 10,
          ),
          CategorySelector(
            listCategory: listArea,
            onChanged: (listAreaSelected) {
              // print(listAreaSelected);
            },
            itemsSelected: [listArea[0]],
            isFlip: false,
          ),
          SizedBox(
            height: 5,
          ),
          ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Area(
                  data: listAreaData[index],
                  done: done,
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: listAreaData.length),
        ],
      ),
    );
  }
}

class Area extends StatelessWidget {
  final AreaData data;
  final onTableSelected done;
  const Area({
    super.key,
    required this.data,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    var (_, avaliable) = data.getStatus;
    List<TableDetailData> listTable = data.listTable ?? [];
    int tableNo = listTable.length;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.areaName ?? 'unknow',
              style: headStyleMedium,
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
                return AddNewTable();
              }
              return TableItem(
                tableDetailData: listTable[index],
                done: (table) {
                  table.detail = data.areaName;
                  done(table);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class AddNewTable extends StatelessWidget {
  const AddNewTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            colorFilter: ColorFilter.mode(
              MainHighColor,
              BlendMode.srcIn,
            ),
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
    );
  }
}

class TableItem extends StatelessWidget {
  final TableDetailData tableDetailData;
  final onTableSelected done;
  const TableItem({
    super.key,
    required this.tableDetailData,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = tableDetailData.isUsed;
    String timeElasped = tableDetailData.timeElapsed;
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          return;
        }
        done(tableDetailData);
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
          children: [
            Container(
              color: isSelected ? TableHighBGColor : TableHeaderBGColor,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tableDetailData.tableName ?? 'unknow',
                    style: isSelected
                        ? headStyleMediumNormaWhite
                        : headStyleMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: isSelected
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadSvg(assetPath: 'svg/time_filled.svg'),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              timeElasped,
                              style: subInfoStyLargeTable400,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadSvg(assetPath: 'svg/money_alt.svg'),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              tableDetailData.price.toString(),
                              style: subInfoStyLargeTable400,
                            )
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: LoadSvg(assetPath: 'svg/table_filled.svg'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Status extends StatelessWidget {
  final ListAreDataResult data;
  const Status({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var (inUsed, available) = data.getStatus;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                LoadSvg(assetPath: 'svg/table.svg'),
                SizedBox(
                  width: 19,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Còn trống: ',
                    style: subInfoStyLarge500,
                    children: [
                      TextSpan(
                          text: '$available', style: subInfoStyLarge600High)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 20,
              child: const VerticalDivider(
                width: 32,
              )),
          Expanded(
            child: Row(
              children: [
                LoadSvg(assetPath: 'svg/time.svg'),
                SizedBox(
                  width: 19,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Đang sử dụng: ',
                    style: subInfoStyLarge500,
                    children: [
                      TextSpan(text: '$inUsed', style: subInfoStyLarge600High)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

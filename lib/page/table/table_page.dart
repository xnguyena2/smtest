import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/page/table/component/modal_create_area.dart';
import 'package:sales_management/page/table/component/modal_create_table.dart';
import 'package:sales_management/page/table/component/modal_update_area.dart';
import 'package:sales_management/page/table/component/modal_update_table.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/storage_provider.dart';
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
  late Future<ListAreDataResult> loadingListArea;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingListArea = getAllTable(groupID);
  }

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
          future: loadingListArea,
          successBuilder: (data) {
            context.read<StorageProvider>().setListArea = data.listResult;
            return Body(
              data: data,
              done: widget.done,
              isEditting: isEditting,
            );
          },
        ),
        floatingActionButton: isEditting
            ? FloatingActionButton.extended(
                elevation: 2,
                backgroundColor: MainHighColor,
                shape: RoundedRectangleBorder(
                  borderRadius: floatBottomBorderRadius,
                ),
                onPressed: () {
                  final areaData = AreaData(
                      id: 0,
                      groupId: groupID,
                      createat: null,
                      areaId: '',
                      listTable: []);
                  showDefaultModal(
                    context: context,
                    content: ModalCreateArea(
                      area: areaData,
                      onDone: (newArea) {
                        updateAreaData(areaData).then(
                          (value) {
                            context
                                .read<StorageProvider>()
                                .listAreaData
                                ?.add(value);
                            showNotification(
                                context, 'Thêm vùng thành công!');
                            setState(() {});
                          },
                        ).onError(
                          (error, stackTrace) {
                            showAlert(context, 'Không thể cập nhật!');
                          },
                        );
                      },
                    ),
                  );
                },
                icon: LoadSvg(
                  assetPath: 'svg/plus_large_width_2.svg',
                  color: White,
                ),
                label: Text(
                  'Thêm khu vực',
                  style: customerNameBigWhite600,
                ),
              )
            : null,
      ),
    );
  }
}

class Body extends StatefulWidget {
  final onTableSelected done;
  final ListAreDataResult data;
  final isEditting;
  const Body({
    super.key,
    required this.data,
    required this.done,
    required this.isEditting,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: BackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Status(
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
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Area(
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
          ],
        ),
      ),
    );
  }
}

class Area extends StatefulWidget {
  final AreaData data;
  final onTableSelected done;
  final bool isEditting;
  final VoidCallbackArg<TableDetailData> successNewTable;
  final VoidCallbackArg<AreaData> successNewListTable;
  final VoidCallbackArg<AreaData> successNewUpdateAreaData;
  final VoidCallbackArg<AreaData> successDeleteAreaData;
  const Area({
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
  State<Area> createState() => _AreaState();
}

class _AreaState extends State<Area> {
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

class TableItem extends StatefulWidget {
  final VoidCallbackArg<TableDetailData> successDeleteTableData;
  final TableDetailData tableDetailData;
  final onTableSelected done;
  final bool isEditting;
  const TableItem({
    super.key,
    required this.tableDetailData,
    required this.done,
    required this.isEditting,
    required this.successDeleteTableData,
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
        if (isSelected || widget.isEditting) {
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
                            tableDetailData.price.toString(),
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

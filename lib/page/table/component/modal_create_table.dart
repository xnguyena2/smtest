import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/page/table/component/modal_select_area.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalCreateTable extends StatefulWidget {
  final AreaData area;
  final VoidCallbackArg<TableDetailData> onDone;
  final VoidCallbackArg<AreaData> onDoneListTable;
  const ModalCreateTable({
    super.key,
    required this.area,
    required this.onDone,
    required this.onDoneListTable,
  });

  @override
  State<ModalCreateTable> createState() => _ModalCreateTableState();
}

class _ModalCreateTableState extends State<ModalCreateTable> {
  int tabIndex = 0;
  bool isActiveOk = false;
  bool isActiveManyOk = false;
  int? firstNumber;
  int? lastNumber;
  String? prefix = 'Bàn';
  late TableDetailData newTable;

  late AreaData area;

  void checkOkForCreateMany() {
    if (firstNumber == null) {
      isActiveManyOk = false;
      return;
    }
    if (lastNumber == null) {
      isActiveManyOk = false;
      return;
    }
    if (prefix == null) {
      isActiveManyOk = false;
      return;
    }
    if (lastNumber! < firstNumber!) {
      isActiveManyOk = false;
      return;
    }
    isActiveManyOk = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    area = widget.area;
    newTable = TableDetailData(
        id: 0,
        groupId: area.groupId,
        createat: null,
        areaId: area.areaId,
        tableId: '',
        tableName: '',
        price: 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double tabWidth = width / 2;
    return ModalBase(
      headerTxt: 'Tạo bàn mới',
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColoredBox(
              color: White,
              child: TabBar(
                onTap: (tabIndex) {
                  this.tabIndex = tabIndex;
                  setState(() {});
                },
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                isScrollable: true,
                indicatorColor: HighColor,
                labelColor: HighColor,
                labelStyle: headStyleMedium500,
                indicatorWeight: 1,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: tabWidth,
                      child: const Center(
                          child: Text(
                        'Tạo 1 bàn',
                        style: headStyleSmallLarge,
                      )),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: tabWidth,
                      child: const Center(
                          child: Text(
                        'Tạo hàng loạt',
                        style: headStyleSmallLarge,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            if (tabIndex == 0)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      children: [
                        InputFiledWithHeader(
                          header: 'Khu vực',
                          hint: 'Chọn khu vực',
                          initValue: area.areaName,
                          isImportance: true,
                          isDropDown: true,
                          onSelected: () {
                            showDefaultModal(
                              context: context,
                              content: ModalSelectArea(
                                selectedArea: area,
                                onDone: (area) {
                                  this.area = area;
                                  newTable.areaId = area.areaId;
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        InputFiledWithHeader(
                          key: ValueKey('${newTable.tableId} 1'),
                          isAutoFocus: true,
                          header: 'Tên bàn',
                          hint: 'Nhập tên bàn',
                          isImportance: true,
                          onChanged: (tableName) {
                            isActiveOk = tableName.isNotEmpty;
                            newTable.tableName = tableName;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  BottomBar(
                    done: () {
                      widget.onDone(newTable);
                      Navigator.pop(context);
                    },
                    cancel: () {
                      Navigator.pop(context);
                    },
                    okBtnTxt: 'Tạo mới',
                    isActiveOk: isActiveOk,
                  ),
                ],
              ),
            if (tabIndex == 1)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputFiledWithHeader(
                          header: 'Khu vực',
                          hint: 'Chọn khu vực',
                          initValue: area.areaName,
                          isImportance: true,
                          isDropDown: true,
                          onSelected: () {
                            showDefaultModal(
                              context: context,
                              content: ModalSelectArea(
                                selectedArea: area,
                                onDone: (area) {
                                  this.area = area;
                                  newTable.areaId = area.areaId;
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        InputFiledWithHeader(
                          key: ValueKey('${newTable.tableId} 2'),
                          header: 'Tiền tố',
                          hint: 'ví dụ: Bàn',
                          initValue: prefix,
                          isImportance: true,
                          onChanged: (value) {
                            prefix = value;
                            checkOkForCreateMany();
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Text(
                          'Tền bàn = {Tiền tố} + {Số thứ tự}. Ví dụ: Bàn 1.',
                          style: headStyleMediumHigh,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InputFiledWithHeader(
                                isAutoFocus: true,
                                isNumberOnly: true,
                                header: 'Số bắt đầu',
                                hint: 'ví dụ: 1',
                                isImportance: true,
                                onChanged: (value) {
                                  firstNumber = int.tryParse(value);
                                  checkOkForCreateMany();
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: InputFiledWithHeader(
                                isNumberOnly: true,
                                header: 'Số kết thúc',
                                hint: 'ví dụ: 10',
                                isImportance: true,
                                onChanged: (value) {
                                  lastNumber = int.tryParse(value);
                                  checkOkForCreateMany();
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  BottomBar(
                    done: () {
                      if (prefix == null ||
                          firstNumber == null ||
                          lastNumber == null) {
                        return;
                      }
                      widget.onDoneListTable(AreaData.fromPrefix(
                          prefix!, firstNumber!, lastNumber!, newTable));
                      Navigator.pop(context);
                    },
                    cancel: () {
                      Navigator.pop(context);
                    },
                    okBtnTxt: 'Tạo mới',
                    isActiveOk: isActiveManyOk,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

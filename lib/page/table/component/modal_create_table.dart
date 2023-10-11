import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/component/modal_base.dart';
import 'package:sales_management/page/table/component/modal_select_area.dart';
import 'package:sales_management/utils/constants.dart';

class ModalCreateTable extends StatefulWidget {
  final AreaData area;
  const ModalCreateTable({
    super.key,
    required this.area,
  });

  @override
  State<ModalCreateTable> createState() => _ModalCreateTableState();
}

class _ModalCreateTableState extends State<ModalCreateTable> {
  int tabIndex = 0;
  bool isActiveOk = false;

  late AreaData area;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    area = widget.area;
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
              child: Row(
                children: [
                  TabBar(
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
                          header: 'Tên bàn',
                          hint: 'Nhập tên bàn',
                          isImportance: true,
                          onChanged: (tableName) {
                            isActiveOk = tableName.isNotEmpty;
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
                    done: () {},
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
                          header: 'Tiền tố',
                          hint: 'ví dụ: Bàn',
                          isImportance: true,
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
                                header: 'Số bắt đầu',
                                hint: 'ví dụ: 1',
                                isImportance: true,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: InputFiledWithHeader(
                                header: 'Số kết thúc',
                                hint: 'ví dụ: 10',
                                isImportance: true,
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
                    done: () {},
                    cancel: () {
                      Navigator.pop(context);
                    },
                    okBtnTxt: 'Tạo mới',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

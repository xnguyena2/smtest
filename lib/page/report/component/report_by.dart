import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/dropdown/dropdown.dart';
import 'package:sales_management/page/report/api/list_buyer_benefit.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/list_order_benefit.dart';
import 'package:sales_management/page/report/api/list_product_benefit.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class ReportBy extends StatefulWidget {
  final String? begin;
  final String? end;
  final bool isShowProfit;
  const ReportBy({
    super.key,
    this.begin,
    this.end,
    required this.isShowProfit,
  });

  @override
  State<ReportBy> createState() => _ReportByState();
}

class _ReportByState extends State<ReportBy> {
  static const list = [
    'Sản phẩm',
    'Đơn hàng',
    'Ngày',
    'Khách hàng',
    'Nhân viên'
  ];
  String dropdownValue = list.first;

  late Widget reportWidget = getReport;

  Widget get getReport {
    if (dropdownValue == 'Sản phẩm') {
      return ReportByProductAsTable(
        begin: widget.begin,
        end: widget.end,
        isShowProfit: widget.isShowProfit,
      );
    }
    if (dropdownValue == 'Khách hàng') {
      return ReportByBuyerAsTable(
        begin: widget.begin,
        end: widget.end,
        isShowProfit: widget.isShowProfit,
      );
    }

    if (dropdownValue == 'Đơn hàng') {
      return ReportByOrderAsTable(
        begin: widget.begin,
        end: widget.end,
        isShowProfit: widget.isShowProfit,
      );
    }

    if (dropdownValue == 'Ngày') {
      return ReportByDayAsTable(
        begin: widget.begin,
        end: widget.end,
        isShowProfit: widget.isShowProfit,
      );
    }

    if (dropdownValue == 'Nhân viên') {
      return ReportByStaffAsTable(
        begin: widget.begin,
        end: widget.end,
        isShowProfit: widget.isShowProfit,
      );
    }

    return ReportByProductAsTable(
      begin: widget.begin,
      end: widget.end,
      isShowProfit: widget.isShowProfit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Text(
                'Báo cáo theo',
                style: headStyleLargeBlackLigh,
              ),
              SizedBox(
                width: 6,
              ),
              DropDownCustome(
                list: list,
                onChanged: (value) {
                  dropdownValue = value;
                  reportWidget = getReport;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        reportWidget,
      ],
    );
  }
}

class ReportByBuyerAsTable extends StatelessWidget {
  final String? begin;
  final String? end;
  final bool isShowProfit;
  const ReportByBuyerAsTable({
    super.key,
    required this.begin,
    required this.end,
    required this.isShowProfit,
  });

  @override
  Widget build(BuildContext context) {
    return FetchAPI<ListBuyerBenifitDataResult>(
      future: getReportOfBuyer(
        start: begin,
        end: end,
      ),
      successBuilder: (ListProductBenifitDataResult) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: BackgroundColor,
                dividerTheme: const DividerThemeData(
                  color: BackgroundColor,
                  space: 0,
                  thickness: 0,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: DataTable(
                horizontalMargin: 12,
                headingRowHeight: 0,
                headingTextStyle: subInfoStyLarge400,
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: [
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  if (isShowProfit) const DataColumn(label: SizedBox()),
                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'KHÁCH HÀNG',
                            style: subInfoStyLarge400,
                          ),
                        ],
                      )),
                      const DataCell(
                        Text(
                          'ĐƠN',
                          style: subInfoStyLarge400,
                        ),
                      ),
                      const DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'D.THU',
                              style: subInfoStyLarge400,
                            ),
                          ],
                        ),
                      ),
                      if (isShowProfit)
                        const DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'L.NHUẬN',
                                style: subInfoStyLarge400,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  ...ListProductBenifitDataResult.listResult
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${e.name?.isNotEmpty == true ? e.name : 'Khách lẻ'}',
                                  style: headStyleMedium,
                                ),
                                if (e.id?.isNotEmpty == true)
                                  ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 80),
                                    child: Text(
                                      '${e.id}',
                                      style: subStyleMediumNormalLight,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            )),
                            DataCell(
                              Text(
                                e.count.toString(),
                                style: headStyleMedium,
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    MoneyFormater.format(e.revenue),
                                    style: headStyleMedium,
                                  ),
                                ],
                              ),
                            ),
                            if (isShowProfit)
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      MoneyFormater.format(e.profit),
                                      style: headStyleMedium,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ReportByStaffAsTable extends StatelessWidget {
  final String? begin;
  final String? end;
  final bool isShowProfit;
  const ReportByStaffAsTable({
    super.key,
    required this.begin,
    required this.end,
    required this.isShowProfit,
  });

  @override
  Widget build(BuildContext context) {
    return FetchAPI<ListBuyerBenifitDataResult>(
      future: getReportOfStaff(
        start: begin,
        end: end,
      ),
      successBuilder: (ListProductBenifitDataResult) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: BackgroundColor,
                dividerTheme: const DividerThemeData(
                  color: BackgroundColor,
                  space: 0,
                  thickness: 0,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: DataTable(
                horizontalMargin: 12,
                headingTextStyle: subInfoStyLarge400,
                headingRowHeight: 0,
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: [
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  if (isShowProfit) const DataColumn(label: SizedBox()),
                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NHÂN VIÊN',
                            style: subInfoStyLarge400,
                          ),
                        ],
                      )),
                      const DataCell(
                        Text(
                          'ĐƠN',
                          style: subInfoStyLarge400,
                        ),
                      ),
                      const DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'D.THU',
                              style: subInfoStyLarge400,
                            ),
                          ],
                        ),
                      ),
                      if (isShowProfit)
                        const DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'L.NHUẬN',
                                style: subInfoStyLarge400,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  ...ListProductBenifitDataResult.listResult
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${e.name?.isNotEmpty == true ? e.name == userPhoneNumber ? 'Chủ quán' : e.name : 'Chủ quán'}',
                                  style: headStyleMedium,
                                ),
                                if (e.id?.isNotEmpty == true)
                                  Text(
                                    '${e.id}',
                                    style: subStyleMediumNormalLight,
                                  ),
                              ],
                            )),
                            DataCell(
                              Text(
                                e.count.toString(),
                                style: headStyleMedium,
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    MoneyFormater.format(e.revenue),
                                    style: headStyleMedium,
                                  ),
                                ],
                              ),
                            ),
                            if (isShowProfit)
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      MoneyFormater.format(e.profit),
                                      style: headStyleMedium,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ReportByProductAsTable extends StatelessWidget {
  final String? begin;
  final String? end;
  final bool isShowProfit;
  const ReportByProductAsTable({
    super.key,
    required this.begin,
    required this.end,
    required this.isShowProfit,
  });

  @override
  Widget build(BuildContext context) {
    return FetchAPI<ListProductBenifitDataResult>(
      future: getReportOfProduct(
        start: begin,
        end: end,
      ),
      successBuilder: (ListProductBenifitDataResult) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: BackgroundColor,
                dividerTheme: const DividerThemeData(
                  color: BackgroundColor,
                  space: 0,
                  thickness: 0,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: DataTable(
                horizontalMargin: 12,
                headingTextStyle: subInfoStyLarge400,
                headingRowHeight: 0,
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: [
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  if (isShowProfit) const DataColumn(label: SizedBox()),
                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SẢN PHẨM',
                            style: subInfoStyLarge400,
                          ),
                        ],
                      )),
                      const DataCell(
                        Text(
                          'SỐ LƯỢNG',
                          style: subInfoStyLarge400,
                        ),
                      ),
                      const DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'D.THU',
                              style: subInfoStyLarge400,
                            ),
                          ],
                        ),
                      ),
                      if (isShowProfit)
                        const DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'L.NHUẬN',
                                style: subInfoStyLarge400,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  ...ListProductBenifitDataResult.listResult
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.product_name ?? 'Đã xóa',
                                  style: headStyleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  e.product_unit_name ?? 'Đã xóa',
                                  style: subStyleMediumNormalLight,
                                ),
                              ],
                            )),
                            DataCell(
                              Text(
                                e.number_unit.toString(),
                                style: headStyleMedium,
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    MoneyFormater.format(e.revenue),
                                    style: headStyleMedium,
                                  ),
                                ],
                              ),
                            ),
                            if (isShowProfit)
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      MoneyFormater.format(e.profit),
                                      style: headStyleMedium,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ReportByOrderAsTable extends StatelessWidget {
  final String? begin;
  final String? end;
  final bool isShowProfit;
  const ReportByOrderAsTable({
    super.key,
    required this.begin,
    required this.end,
    required this.isShowProfit,
  });

  @override
  Widget build(BuildContext context) {
    return FetchAPI<ListOrderBenifitDataResult>(
      future: getReportOfOrder(
        start: begin,
        end: end,
      ),
      successBuilder: (ListProductBenifitDataResult) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: BackgroundColor,
                dividerTheme: const DividerThemeData(
                  color: BackgroundColor,
                  space: 0,
                  thickness: 0,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: DataTable(
                horizontalMargin: 12,
                headingTextStyle: subInfoStyLarge400,
                headingRowHeight: 0,
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: [
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  if (isShowProfit) const DataColumn(label: SizedBox()),
                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ĐƠN HÀNG',
                              style: subInfoStyLarge400,
                            ),
                          ],
                        ),
                      ),
                      const DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'D.THU',
                              style: subInfoStyLarge400,
                            ),
                          ],
                        ),
                      ),
                      if (isShowProfit)
                        const DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'L.NHUẬN',
                                style: subInfoStyLarge400,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  ...ListProductBenifitDataResult.listResult
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${e.package_second_id.substring(0, 8).toUpperCase()}',
                                  style: headStyleMedium,
                                ),
                                Text(
                                  '${formatSplashLocalDateTime(e.createat)}',
                                  style: subStyleMediumNormalLight,
                                ),
                              ],
                            )),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    MoneyFormater.format(e.revenue),
                                    style: headStyleMedium,
                                  ),
                                ],
                              ),
                            ),
                            if (isShowProfit)
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      MoneyFormater.format(e.profit),
                                      style: headStyleMedium,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ReportByDayAsTable extends StatelessWidget {
  final String? begin;
  final String? end;
  final bool isShowProfit;
  const ReportByDayAsTable({
    super.key,
    required this.begin,
    required this.end,
    required this.isShowProfit,
  });

  @override
  Widget build(BuildContext context) {
    return FetchAPI<ListDateBenifitDataResult>(
      future: getReportOfCurrentMonthByDate(
        start: begin,
        end: end,
        fillAll: false,
      ),
      successBuilder: (ListProductBenifitDataResult) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: BackgroundColor,
                dividerTheme: const DividerThemeData(
                  color: BackgroundColor,
                  space: 0,
                  thickness: 0,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: DataTable(
                horizontalMargin: 12,
                headingTextStyle: subInfoStyLarge400,
                headingRowHeight: 0,
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: [
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  const DataColumn(label: SizedBox()),
                  if (isShowProfit) const DataColumn(label: SizedBox()),
                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text(
                        'NGÀY',
                        style: subInfoStyLarge400,
                      )),
                      const DataCell(Text(
                        'ĐƠN',
                        style: subInfoStyLarge400,
                      )),
                      const DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'D.THU',
                              style: subInfoStyLarge400,
                            ),
                          ],
                        ),
                      ),
                      if (isShowProfit)
                        const DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'L.NHUẬN',
                                style: subInfoStyLarge400,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  ...ListProductBenifitDataResult.listResult
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              '${e.localTime}',
                              style: headStyleMedium,
                            )),
                            DataCell(Text(
                              '${e.count}',
                              style: headStyleMedium,
                            )),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    MoneyFormater.format(e.revenue),
                                    style: headStyleMedium,
                                  ),
                                ],
                              ),
                            ),
                            if (isShowProfit)
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      MoneyFormater.format(e.profit),
                                      style: headStyleMedium,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

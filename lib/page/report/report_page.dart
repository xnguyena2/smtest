import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/dropdown/dropdown.dart';
import 'package:sales_management/page/home/compoment/monthly_report.dart';
import 'package:sales_management/page/report/api/list_buyer_benefit.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/list_order_benefit.dart';
import 'package:sales_management/page/report/api/list_product_benefit.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late Future<ListDateBenifitDataResult> _loadData;
  String? start;
  String? end;

  void refresh() {
    _loadData = getReportOfCurrentMonthByDate(start: start, end: end);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: ReportBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TimeSelector(
                onChagneDateTime: (DateTimeRange) {
                  start = localDateTime2ServerFormat(DateTimeRange.start);
                  end = localDateTime2ServerFormat(
                      DateTimeRange.end.add(Duration(days: 1)));
                  refresh();
                  setState(() {});
                },
                onChangeTime: (listTime) {
                  start = listTime[0];
                  end = listTime[1];
                  if (listTime[0].isEmpty) {
                    start = end = null;
                  }
                  refresh();
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FetchAPI<ListDateBenifitDataResult>(
                future: _loadData,
                successBuilder: (ListDateBenifitDataResult) {
                  double totalPrice = ListDateBenifitDataResult.totalPrice;
                  double totalRevenue = ListDateBenifitDataResult.totalRevenue;
                  double totalCost = ListDateBenifitDataResult.totalCost;
                  double totalProfit = ListDateBenifitDataResult.totalProfit;
                  double totalDiscount =
                      ListDateBenifitDataResult.totalDiscount;
                  double totalShipPrice =
                      ListDateBenifitDataResult.totalShipPrice;
                  int numOrder = ListDateBenifitDataResult.numOrder;
                  int numbuyer = ListDateBenifitDataResult.numberBuyer;
                  return SingleChildScrollView(
                    child: Container(
                      color: BackgroundColor,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          _MainInfo(
                            totalRevenue: totalRevenue,
                            numOrder: numOrder,
                            numbuyer: numbuyer,
                            totalProfit: totalProfit,
                            totalCost: totalCost,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MonthlyReport(
                            margin: null,
                            padding: EdgeInsets.zero,
                            enableShowReportPageBtn: false,
                            listResult: ListDateBenifitDataResult,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ReportAsTable(
                            header: 'Phương thức thanh toán',
                            datas: {
                              'Tiền mặt': MoneyFormater.format(totalRevenue),
                              'Đã ghi nợ': '0',
                              'Chưa thanh toán': MoneyFormater.format(
                                  totalPrice +
                                      totalShipPrice -
                                      totalDiscount -
                                      totalRevenue),
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ReportAsTable(
                            header: 'Doanh thu chi tiết',
                            datas: {
                              'Tổng giá bán':
                                  MoneyFormater.format(totalPrice),
                              'Giảm giá': MoneyFormater.format(totalDiscount),
                              'Phí vận chuyển':
                                  MoneyFormater.format(totalShipPrice),
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ReportBy(
                            begin: start,
                            end: end,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportAsTable extends StatelessWidget {
  final String header;
  final Map<String, String> datas;
  const ReportAsTable({
    super.key,
    required this.datas,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            '$header',
            style: headStyleLargeBlackLigh,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
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
            decoration: const BoxDecoration(
              color: White,
            ),
            headingRowHeight: 0,
            dividerThickness: 0,
            border: TableBorder.symmetric(
                inside: const BorderSide(width: 1.5, color: BackgroundColor)),
            columns: const [
              DataColumn(label: SizedBox()),
              DataColumn(label: SizedBox()),
            ],
            rows: datas.entries
                .map(
                  (e) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        e.key,
                        style: subInfoStyLarge400,
                      )),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              e.value,
                              style: headStyleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class ReportBy extends StatefulWidget {
  final String? begin;
  final String? end;
  const ReportBy({
    super.key,
    this.begin,
    this.end,
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
      );
    }
    if (dropdownValue == 'Khách hàng') {
      return ReportByBuyerAsTable(
        begin: widget.begin,
        end: widget.end,
      );
    }

    if (dropdownValue == 'Đơn hàng') {
      return ReportByOrderAsTable(
        begin: widget.begin,
        end: widget.end,
      );
    }

    if (dropdownValue == 'Ngày') {
      return ReportByDayAsTable(
        begin: widget.begin,
        end: widget.end,
      );
    }

    if (dropdownValue == 'Nhân viên') {
      return ReportByStaffAsTable(
        begin: widget.begin,
        end: widget.end,
      );
    }

    return ReportByProductAsTable(
      begin: widget.begin,
      end: widget.end,
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
  const ReportByBuyerAsTable({
    super.key,
    required this.begin,
    required this.end,
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
                headingTextStyle: subInfoStyLarge400,
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: const [
                  DataColumn(label: Text('KHÁCH HÀNG')),
                  DataColumn(label: Text('ĐƠN')),
                  DataColumn(label: Text('DOANH THU')),
                ],
                rows: ListProductBenifitDataResult.listResult
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
                        ],
                      ),
                    )
                    .toList(),
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
  const ReportByStaffAsTable({
    super.key,
    required this.begin,
    required this.end,
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
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: const [
                  DataColumn(label: Text('NHÂN VIÊN')),
                  DataColumn(label: Text('ĐƠN')),
                  DataColumn(label: Text('DOANH THU')),
                ],
                rows: ListProductBenifitDataResult.listResult
                    .map(
                      (e) => DataRow(
                        cells: <DataCell>[
                          DataCell(Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${e.name?.isNotEmpty == true ? e.name == userPhoneNumber ? 'Chú quán' : e.name : 'Chú quán'}',
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
                        ],
                      ),
                    )
                    .toList(),
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
  const ReportByProductAsTable({
    super.key,
    required this.begin,
    required this.end,
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
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: const [
                  DataColumn(label: Text('SẢN PHẨM')),
                  DataColumn(label: Text('SỐ LƯỢNG')),
                  DataColumn(label: Text('DOANH THU')),
                ],
                rows: ListProductBenifitDataResult.listResult
                    .map(
                      (e) => DataRow(
                        cells: <DataCell>[
                          DataCell(Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${e.product_name}',
                                style: headStyleMedium,
                              ),
                              if (e.product_unit_name?.isNotEmpty == true)
                                Text(
                                  '${e.product_unit_name}',
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
                        ],
                      ),
                    )
                    .toList(),
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
  const ReportByOrderAsTable({
    super.key,
    required this.begin,
    required this.end,
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
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: const [
                  DataColumn(label: Text('ĐƠN HÀNG')),
                  DataColumn(label: Text('DOANH THU')),
                ],
                rows: ListProductBenifitDataResult.listResult
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
                        ],
                      ),
                    )
                    .toList(),
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
  const ReportByDayAsTable({
    super.key,
    required this.begin,
    required this.end,
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
                decoration: const BoxDecoration(
                  color: White,
                ),
                dividerThickness: 0,
                border: TableBorder.symmetric(
                    inside:
                        const BorderSide(width: 1.5, color: BackgroundColor)),
                columns: const [
                  DataColumn(label: Text('NGÀY')),
                  DataColumn(label: Text('ĐƠN')),
                  DataColumn(label: Text('KHÁCH')),
                  DataColumn(label: Text('D.THU')),
                ],
                rows: ListProductBenifitDataResult.listResult
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
                          DataCell(Text(
                            '${e.buyer}',
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
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MainInfo extends StatelessWidget {
  const _MainInfo({
    super.key,
    required this.totalRevenue,
    required this.numOrder,
    required this.numbuyer,
    required this.totalProfit,
    required this.totalCost,
  });

  final double totalRevenue;
  final double totalProfit;
  final double totalCost;
  final int numOrder;
  final int numbuyer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: bigRoundBorderRadius,
        color: const Color(0xFFD8DFE9),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      'Doanh thu:',
                      style: headStyleSmallLargeLigh,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      MoneyFormater.format(totalRevenue),
                      style: totalMoneyStylexxXLargeBlack,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Đơn hàng:',
                        style: headStyleSmallLargeLigh,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '$numOrder',
                        style: headStyleSemiLarge500,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  Column(
                    children: [
                      Text(
                        'Khách hàng:',
                        style: headStyleSmallLargeLigh,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '$numbuyer',
                        style: headStyleSemiLarge500,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: White,
                    borderRadius: bigRoundBorderRadius,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Black,
                            child: CircleAvatar(
                              backgroundColor: White,
                              radius: 14,
                              child: LoadSvg(assetPath: 'svg/profit_graph.svg'),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Lợi nhuận',
                            style: headStyleSmallLargeLigh,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      SizedBox(
                        height: 30,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Row(
                              children: [
                                Text(
                                  MoneyFormater.format(totalProfit),
                                  style: totalMoneyStylexxXLargeBlack,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: TableHighColor,
                                    borderRadius: defaultBorderRadius,
                                  ),
                                  child: Text(
                                    '${(100 * totalProfit / totalRevenue).toStringAsFixed(1)}%',
                                    style: subInfoStyMedium500White,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: White,
                    borderRadius: bigRoundBorderRadius,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Black,
                            child: CircleAvatar(
                              backgroundColor: White,
                              radius: 14,
                              child:
                                  LoadSvg(assetPath: 'svg/price_tag_round.svg'),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Giá vốn',
                            style: headStyleSmallLargeLigh,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      SizedBox(
                        height: 30,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  MoneyFormater.format(totalCost),
                                  style: totalMoneyStylexxXLargeBlack,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Red,
                                    borderRadius: defaultBorderRadius,
                                  ),
                                  child: Text(
                                    '${(100 * totalCost / totalRevenue).toStringAsFixed(1)}%',
                                    style: subInfoStyMedium500White,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeSelector extends StatefulWidget {
  final VoidCallbackArg<DateTimeRange> onChagneDateTime;
  final VoidCallbackArg<List<String>> onChangeTime;
  static const List<String> listTime = [
    'Hôm nay',
    'Tháng này',
    'Tháng trước'
  ];
  const TimeSelector({
    super.key,
    required this.onChagneDateTime,
    required this.onChangeTime,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String currentRange = 'Tháng này';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () async {
                  DateTimeRange? dt = await showDateRangePicker(
                      context: context,
                      locale: const Locale("vi", "VN"),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 300.0,
                            ),
                            child: child,
                          ),
                        );
                      });
                  if (dt != null) {
                    currentRange =
                        '${formatLocalDateTimeOnlyDateSplashFromDate(dt.start)} - ${formatLocalDateTimeOnlyDateSplashFromDate(dt.end)}';
                    widget.onChagneDateTime(dt);
                  }
                },
                child: LoadSvg(assetPath: 'svg/calendar_month.svg'),
              ),
              const SizedBox(
                width: 10,
              ),
              currentRange.contains(' - ')
                  ? Row(
                      children: [
                        Text(currentRange),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            currentRange = '';
                            setState(() {});
                          },
                          child: LoadSvg(assetPath: 'svg/close_circle.svg'),
                        ),
                      ],
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String value = TimeSelector.listTime[index];
                        return UnconstrainedBox(
                          child: GestureDetector(
                            onTap: () {
                              currentRange = value;
                              if (currentRange == 'Hôm nay') {
                                widget.onChangeTime([
                                  getLastDateTimeNow(),
                                  getCurrentDateTimeNow()
                                ]);
                                setState(() {});
                                return;
                              }
                              if (currentRange == 'Tháng này') {
                                widget.onChangeTime(['', '']);
                                setState(() {});
                                return;
                              }
                              if (currentRange == 'Tháng trước') {
                                widget.onChangeTime([
                                  getFirstDateTimeOfLastMonth(),
                                  getLastDateTimeOfLastMonth()
                                ]);
                                setState(() {});
                                return;
                              }
                            },
                            child: TimeHightLight(
                              isSelected: value == currentRange,
                              txt: value,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: TimeSelector.listTime.length)
            ],
          ),
        ],
      ),
    );
  }
}

class TimeHightLight extends StatelessWidget {
  final bool isSelected;
  final String txt;
  const TimeHightLight({
    super.key,
    required this.isSelected,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: bigRoundBorderRadius,
        color: isSelected ? PurpelColor : TransaprentColor,
      ),
      child: Text(
        txt,
        style: isSelected
            ? headStyleSemiLargeWhite500
            : headStyleSemiLargeSLigh500,
      ),
    );
  }
}

class ReportItemInfo extends StatelessWidget {
  final String header;
  final String content;
  final TextStyle style;
  const ReportItemInfo({
    super.key,
    required this.header,
    required this.content,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: headStyleXLargeLigh,
        ),
        Text(
          content,
          style: style,
        ),
      ],
    );
  }
}

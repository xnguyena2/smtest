import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/home/compoment/monthly_report.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
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
        appBar: ReportBar(
          onChagneDateTime: (DateTimeRange) {
            start = localDateTime2ServerFormat(DateTimeRange.start);
            end = localDateTime2ServerFormat(
                DateTimeRange.end.add(Duration(days: 1)));
            refresh();
            setState(() {});
          },
        ),
        body: FetchAPI<ListDateBenifitDataResult>(
          future: _loadData,
          successBuilder: (ListDateBenifitDataResult) {
            double totalRevenue = ListDateBenifitDataResult.totalRevenue;
            double totalCost = ListDateBenifitDataResult.totalCost;
            double totalProfit = ListDateBenifitDataResult.totalProfit;
            int numOrder = ListDateBenifitDataResult.numOrder;
            int numbuyer = ListDateBenifitDataResult.numberBuyer;
            return SingleChildScrollView(
              child: Container(
                color: BackgroundColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TimeSelector(),
                    ),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeSelector extends StatelessWidget {
  static const List<String> listTime = [
    'Hôm nay',
    'Tháng này',
    'Tháng trước'
  ];
  const TimeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return LoadSvg(assetPath: 'svg/calendar_month.svg');
            }

            String value = listTime[index - 1];
            return UnconstrainedBox(
              child: TimeHightLight(
                isSelected: true,
                txt: value,
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
          itemCount: listTime.length + 1),
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

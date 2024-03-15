import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/component/dropdown/dropdown.dart';
import 'package:sales_management/component/interface/list_report_interface.dart';
import 'package:sales_management/page/home/compoment/navigation_next.dart';
import 'package:sales_management/page/report/report_page.dart';

import '../../../utils/constants.dart';

class MonthlyReport extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final bool enableShowReportPageBtn;
  final ListReportInterface? listResult;
  final bool isShowOnlyProfit;
  const MonthlyReport({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
    this.enableShowReportPageBtn = true,
    this.margin,
    this.listResult,
    this.isShowOnlyProfit = false,
  });

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  late int showingTooltip = -1;
  static const List<String> list = <String>[
    'Doanh thu',
    'Lợi nhuận',
    'Đơn hàng',
    'Khách hàng'
  ];
  late String dropdownValue = widget.isShowOnlyProfit ? list[1] : list.first;
  List<BarChartGroupData> get rawProfitBarGroups => widget.listResult == null
      ? []
      : widget.listResult!
          .getListResultFlat()
          .map((e) => BarChartGroupData(
                barsSpace: 4,
                x: e.offset,
                barRods: [
                  BarChartRodData(
                    toY: e.data.profit,
                    color: e.data.profit > 0 ? TableHighColor : AlertColor,
                    width: 7,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: e.data.profit * 1.2,
                      color: TransaprentColor,
                    ),
                  ),
                ],
                showingTooltipIndicators: showingTooltip == e.offset ? [0] : [],
              ))
          .toList();
  List<BarChartGroupData> get rawRevenueBarGroups => widget.listResult == null
      ? []
      : widget.listResult!
          .getListResultFlat()
          .map((e) => BarChartGroupData(
                barsSpace: 4,
                x: e.offset,
                barRods: [
                  BarChartRodData(
                    toY: e.data.revenue,
                    color: TableHighColor,
                    width: 7,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: e.data.revenue * 1.2,
                      color: TransaprentColor,
                    ),
                  ),
                ],
                showingTooltipIndicators: showingTooltip == e.offset ? [0] : [],
              ))
          .toList();
  List<BarChartGroupData> get rawBuyerBarGroups => widget.listResult == null
      ? []
      : widget.listResult!
          .getListResultFlat()
          .map((e) => BarChartGroupData(
                barsSpace: 4,
                x: e.offset,
                barRods: [
                  BarChartRodData(
                    toY: e.data.buyer.toDouble(),
                    color: TableHighColor,
                    width: 7,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: e.data.buyer.toDouble() * 1.2,
                      color: TransaprentColor,
                    ),
                  ),
                ],
                showingTooltipIndicators: showingTooltip == e.offset ? [0] : [],
              ))
          .toList();
  List<BarChartGroupData> get rawOrderBarGroups => widget.listResult == null
      ? []
      : widget.listResult!
          .getListResultFlat()
          .map((e) => BarChartGroupData(
                barsSpace: 4,
                x: e.offset,
                barRods: [
                  BarChartRodData(
                    toY: e.data.count.toDouble(),
                    color: TableHighColor,
                    width: 7,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: e.data.count.toDouble() * 1.2,
                      color: TransaprentColor,
                    ),
                  ),
                ],
                showingTooltipIndicators: showingTooltip == e.offset ? [0] : [],
              ))
          .toList();

  late List<BarChartGroupData> showingBarGroups = groupBarsData1;

  List<BarChartGroupData> get groupBarsData1 {
    if (dropdownValue == 'Doanh thu') return rawRevenueBarGroups;
    if (dropdownValue == 'Lợi nhuận') return rawProfitBarGroups;
    if (dropdownValue == 'Đơn hàng') return rawOrderBarGroups;
    if (dropdownValue == 'Khách hàng') return rawBuyerBarGroups;
    return rawRevenueBarGroups;
  }

  List<LineChartBarData> get lineBarsData1 => [
        if (dropdownValue == 'Doanh thu') lineRevenueData,
        if (dropdownValue == 'Lợi nhuận') lineProfitData,
        if (dropdownValue == 'Đơn hàng') lineOrderData,
        if (dropdownValue == 'Khách hàng') lineBuyerData,
      ];

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        // minX: 0,
        // maxX: 14,
        // maxY: 10,
        // minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        getTouchedSpotIndicator: (barData, spotIndexes) => spotIndexes.map(
          (int index) {
            const line =
                FlLine(color: borderColor, strokeWidth: 1, dashArray: [2, 4]);
            return const TouchedSpotIndicatorData(
              line,
              FlDotData(show: false),
            );
          },
        ).toList(),
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            tooltipBgColor: White,
            tooltipBorder: BorderSide(color: borderColor, width: 0.5),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                final textStyle = TextStyle(
                  color: touchedSpot.bar.color,
                  fontWeight: FontWeight.bold,
                );
                return LineTooltipItem(
                    MoneyFormater.format(touchedSpot.y), textStyle);
              }).toList();
            }),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = subInfoStyBlackMedium;
    String txt = '';
    if (value > 1000000000) {
      txt = '${MoneyFormater.format(value / 1000000000)}tỷ';
    } else if (value > 1000000) {
      txt = '${MoneyFormater.format(value / 1000000)}tr';
    } else if (value > 1000) {
      txt = '${MoneyFormater.format(value / 1000)}k';
    } else {
      txt = '$value';
    }
    return Text(txt, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        // interval: 100000,
        // reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = subInfoStySmall;
    Widget text;
    String txt =
        widget.listResult?.getTimeStampFrom(offset: value.toInt()) ?? '??';
    text = Text(txt, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Transform.rotate(angle: -1.3, child: text),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        getTitlesWidget: bottomTitleWidgets,
        showTitles: true,
        // interval: 1, //1 day
        // reservedSize: 25,
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) =>
            FlLine(strokeWidth: 1, dashArray: [2, 4], color: borderColor),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.red.withOpacity(0.2), width: 1),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineProfitData => LineChartBarData(
        curveSmoothness: 0.09,
        isCurved: true,
        color: ProfitColor,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: widget.listResult == null
            ? []
            : widget.listResult!
                .getListResultFlat()
                .map((e) => FlSpot(e.offset.toDouble(), e.data.profit))
                .toList(),
      );

  LineChartBarData get lineRevenueData => LineChartBarData(
        curveSmoothness: 0.09,
        isCurved: true,
        color: RevenueColor,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: widget.listResult == null
            ? []
            : widget.listResult!
                .getListResultFlat()
                .map((e) => FlSpot(e.offset.toDouble(), e.data.revenue))
                .toList(),
      );

  LineChartBarData get lineBuyerData => LineChartBarData(
        curveSmoothness: 0.09,
        isCurved: true,
        color: CostColor,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: widget.listResult == null
            ? []
            : widget.listResult!
                .getListResultFlat()
                .map(
                    (e) => FlSpot(e.offset.toDouble(), e.data.buyer.toDouble()))
                .toList(),
      );

  LineChartBarData get lineOrderData => LineChartBarData(
        curveSmoothness: 0.09,
        isCurved: true,
        color: CostColor,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: widget.listResult == null
            ? []
            : widget.listResult!
                .getListResultFlat()
                .map(
                    (e) => FlSpot(e.offset.toDouble(), e.data.count.toDouble()))
                .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: BackgroundColor,
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!widget.isShowOnlyProfit)
                  Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
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
                          showingTooltip = -1;
                          showingBarGroups = groupBarsData1;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                widget.enableShowReportPageBtn
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportPage(),
                            ),
                          );
                        },
                        child: const NavigationNext(
                          title: 'Xem chi tiết',
                          assetPath: 'svg/small_chart.svg',
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            AspectRatio(
              aspectRatio: 1.23,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                decoration: const BoxDecoration(
                  color: White,
                ),
                child: Stack(
                  children: [
                    // LineChart(
                    //   sampleData1,
                    //   duration: const Duration(milliseconds: 250),
                    // ),
                    BarChart(
                      swapAnimationDuration: const Duration(milliseconds: 500),
                      BarChartData(
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            fitInsideHorizontally: true,
                            tooltipBgColor: Black70,
                            getTooltipItem: (a, b, c, d) {
                              const textStyle = TextStyle(
                                color: White,
                                fontWeight: FontWeight.bold,
                              );
                              return BarTooltipItem(
                                  MoneyFormater.format(c.toY), textStyle);
                            },
                          ),
                          touchCallback: (event, response) {
                            if (response != null &&
                                response.spot != null &&
                                event is FlTapUpEvent) {
                              final x = response.spot!.touchedBarGroup.x;
                              final isShowing = showingTooltip == x;
                              if (isShowing) {
                                showingTooltip = -1;
                              } else {
                                showingTooltip = x;
                              }
                              showingBarGroups = groupBarsData1;
                              setState(() {});
                            }
                          },
                          mouseCursorResolver: (event, response) {
                            return response == null || response.spot == null
                                ? MouseCursor.defer
                                : SystemMouseCursors.click;
                          },
                        ),
                        titlesData: titlesData1,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                        gridData: gridData,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/page/home/compoment/navigation_next.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/utils/utils.dart';

import '../../../utils/constants.dart';

class MonthlyReport extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final bool enableShowReportPageBtn;
  final ListDateBenifitDataResult? listResult;
  const MonthlyReport({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
    this.enableShowReportPageBtn = true,
    this.margin,
    this.listResult,
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
  String dropdownValue = list.first;
  late List<BarChartGroupData> showingBarGroups = widget.listResult == null
      ? []
      : widget.listResult!.listResultFlat
          .map((e) => BarChartGroupData(
                barsSpace: 4,
                x: e.offset,
                barRods: [
                  BarChartRodData(
                    toY: e.dateOfMonth.profit,
                    color: TableHighColor,
                    width: 7,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: e.dateOfMonth.profit * 1.2,
                      color: TransaprentColor,
                    ),
                  ),
                ],
                showingTooltipIndicators: showingTooltip == e.offset ? [0] : [],
              ))
          .toList();

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
    int ts = widget.listResult?.getTimeStampFrom(offset: value.toInt()) ?? 0;
    String txt = ts == 0 ? '--/--/--' : timeStampToFormat(ts);
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
            : widget.listResult!.listResultFlat
                .map((e) => FlSpot(e.offset.toDouble(), e.dateOfMonth.profit))
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
            : widget.listResult!.listResultFlat
                .map((e) => FlSpot(e.offset.toDouble(), e.dateOfMonth.revenue))
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
            : widget.listResult!.listResultFlat
                .map((e) =>
                    FlSpot(e.offset.toDouble(), e.dateOfMonth.buyer.toDouble()))
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
            : widget.listResult!.listResultFlat
                .map((e) =>
                    FlSpot(e.offset.toDouble(), e.dateOfMonth.count.toDouble()))
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
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        items: list
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: subInfoStyLarge600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: dropdownValue,
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 30,
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: defaultBorderRadius,
                            border: tableHighBorder,
                            color: White,
                          ),
                          elevation: 0,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 14,
                          iconEnabledColor: TableHighColor,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: defaultBorderRadius,
                            color: White,
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
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
                        child: NavigationNext(
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
                    // _BarCharttt(),
                    BarChart(
                      BarChartData(
                        // maxY: 20,
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
                            if (response != null && response.spot != null) {
                              setState(() {
                                final x = response.spot!.touchedBarGroup.x;
                                final isShowing = showingTooltip == x;
                                if (isShowing) {
                                  showingTooltip = -1;
                                } else {
                                  showingTooltip = x;
                                }
                              });
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

class _BarCharttt extends StatefulWidget {
  final Color leftBarColor = Colors.yellow;
  final Color rightBarColor = Red;
  final Color avgColor = Colors.orange;
  _BarCharttt({
    super.key,
  });

  @override
  State<_BarCharttt> createState() => _BarChartttState();
}

class _BarChartttState extends State<_BarCharttt> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 20,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            getTooltipItem: (a, b, c, d) => null,
          ),
          touchCallback: (FlTouchEvent event, response) {},
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 42,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: leftTitles,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingBarGroups,
        gridData: const FlGridData(show: false),
      ),
    );
  }
}

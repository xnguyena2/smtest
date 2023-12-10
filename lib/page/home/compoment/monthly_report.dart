import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/page/home/compoment/navigation_next.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/utils/utils.dart';

import '../../../utils/constants.dart';
import 'header.dart';

class MonthlyReport extends StatelessWidget {
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
                    MoneyFormater.format(touchedSpot.y * 1000), textStyle);
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

  List<LineChartBarData> get lineBarsData1 => [
        lineProfitData,
        lineCostData,
        lineRevenueData,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = subInfoStyBlackMedium;
    String txt = '';
    if (value > 1000000) {
      txt = '${MoneyFormater.format(value / 1000000)}tỷ';
    } else if (value > 1000) {
      txt = '${MoneyFormater.format(value / 1000)}tr';
    } else if (value > 0) {
      txt = '${MoneyFormater.format(value)}k';
    } else {
      txt = MoneyFormater.format(value);
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
    int ts = listResult?.getTimeStampFrom(offset: value.toInt()) ?? 0;
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
        interval: 1, //1 day
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
        spots: listResult == null
            ? []
            : listResult!.listResultFlat
                .map((e) =>
                    FlSpot(e.offset.toDouble(), e.dateOfMonth.profit / 1000))
                .toList(),
      );

  LineChartBarData get lineCostData => LineChartBarData(
        curveSmoothness: 0.09,
        isCurved: true,
        color: CostColor,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink.withOpacity(0),
        ),
        spots: listResult == null
            ? []
            : listResult!.listResultFlat
                .map((e) =>
                    FlSpot(e.offset.toDouble(), e.dateOfMonth.cost / 1000))
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
        spots: listResult == null
            ? []
            : listResult!.listResultFlat
                .map((e) =>
                    FlSpot(e.offset.toDouble(), e.dateOfMonth.revenue / 1000))
                .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: BackgroundColor,
      child: Container(
        padding: padding,
        margin: margin,
        child: Column(
          children: [
            header(
              title: 'Báo cáo tháng này',
              titleImg: 'svg/report_header.svg',
              endChild: enableShowReportPageBtn
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
            ),
            AspectRatio(
              aspectRatio: 1.23,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                decoration: BoxDecoration(
                  color: White,
                  borderRadius: defaultBorderRadius,
                ),
                child: LineChart(
                  sampleData1,
                  duration: const Duration(milliseconds: 250),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

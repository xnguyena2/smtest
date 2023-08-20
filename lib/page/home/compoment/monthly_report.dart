import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/page/home/compoment/navigation_next.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';
import 'header.dart';

class MonthlyReport extends StatelessWidget {
  const MonthlyReport({super.key});

  final bool isShowingMainData = true;

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
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
        touchTooltipData: const LineTouchTooltipData(
          tooltipBgColor: White,
          tooltipBorder: BorderSide(color: borderColor, width: 0.5),
        ),
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
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = subInfoStyBlackMedium;
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = subInfoStyMedium400;
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Transform.rotate(angle: -1.3, child: text),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 25,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
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

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Colors.pink,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: Colors.cyan,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Column(
        children: [
          const header(
              title: 'Báo cáo tháng này',
              titleImg: 'svg/report_header.svg',
              endChild: NavigationNext(
                title: 'Xem chi tiết',
                assetPath: 'svg/small_chart.svg',
              )),
          AspectRatio(
            aspectRatio: 1.23,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
    );
  }
}

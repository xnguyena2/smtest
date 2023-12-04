import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';
import '../model/report.dart';
import 'navigation_next.dart';

class QuickReport extends StatelessWidget {
  final BenifitByMonth? benifitByMonth;
  const QuickReport({
    super.key,
    required this.benifitByMonth,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return WidgetContent(
      screenWidth: screenWidth,
      benifitByMonth: benifitByMonth,
    );
  }
}

class WidgetContent extends StatelessWidget {
  final BenifitByMonth? benifitByMonth;
  const WidgetContent({
    super.key,
    required this.screenWidth,
    this.benifitByMonth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    String count = (benifitByMonth?.count ?? 0).toString();
    String revenue = MoneyFormater.format(benifitByMonth?.revenue ?? 0);
    String profit = MoneyFormater.format(benifitByMonth?.profit ?? 0);
    List<report> exampleReport = [
      report(
        title: 'Doanh thu',
        iconHeader: 'svg/income_amount.svg',
        content: revenue,
      ),
      report(
        title: 'Lợi nhuận',
        iconHeader: 'svg/currency_revenue.svg',
        content: profit,
      ),
      report(
        title: 'Đơn hàng',
        iconHeader: 'svg/order_repo.svg',
        content: count,
      ),
    ];
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: SizedBox(
        height: 140,
        width: screenWidth,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              child: Transform.translate(
                offset: Offset(0, screenWidth * 0.28 - 130),
                child: ClipOval(
                  child: Container(
                    height: screenWidth,
                    width: screenWidth * 1.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 72, 188, 255),
                            Color(0xFF184863),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Transform.translate(
                offset: Offset(0, 1),
                child: Container(
                  width: screenWidth,
                  height: 30,
                  color: BackgroundColor,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 120,
                width: screenWidth - 30,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: White,
                  boxShadow: const [wholeShadow],
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 8.5),
                            Text(
                              'Hôm nay',
                              style: subInfoStyLarge500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            NavigationNext(
                              title: 'Báo cáo lãi lỗ',
                              assetPath: 'svg/small_chart.svg',
                            ),
                            SizedBox(width: 8.5),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          report rp = exampleReport[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LoadSvg(assetPath: rp.iconHeader),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      rp.title,
                                      style: subInfoStyMedium500,
                                    ),
                                  ],
                                ),
                                Text(
                                  rp.content,
                                  style: headStyleMedium600,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(),
                            ),
                          ],
                        ),
                        itemCount: exampleReport.length,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

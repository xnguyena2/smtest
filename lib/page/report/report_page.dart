import 'package:flutter/material.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ReportBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            color: BackgroundColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: defaultBorderRadius,
                    color: White,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadSvg(assetPath: 'svg/currency_revenue_solid.svg'),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Lợi nhuận',
                            style: customerNameBig,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '90.000',
                        style: moneyStyleSuperLargeHigh,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

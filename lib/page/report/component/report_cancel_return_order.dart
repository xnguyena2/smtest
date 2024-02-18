import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/report/api/model/count_order_by_date.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ReportCancelAndReturnOrder extends StatelessWidget {
  final String? begin;
  final String? end;
  const ReportCancelAndReturnOrder({
    super.key,
    this.begin,
    this.end,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đơn hủy/trả',
              style: headStyleLargeBlackLigh,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        FetchAPI<CountOrderByDate>(
          future: getCancelAndReturnOfOrder(start: begin, end: end),
          successBuilder: (count) {
            print(count.toJson());
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: White,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadSvg(assetPath: 'svg/key_return_fill.svg'),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${count.count_return} đơn trả',
                              style: subInfoStyLargeLigh400,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${MoneyFormater.format(count.revenue_return)}',
                          style: headStyleSemiLarge600,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadSvg(assetPath: 'svg/cancel_checkout.svg'),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${count.count_cancel} đơn hủy',
                              style: subInfoStyLargeLigh400,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${MoneyFormater.format(count.revenue_cancel)}',
                          style: headStyleSemiLarge600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

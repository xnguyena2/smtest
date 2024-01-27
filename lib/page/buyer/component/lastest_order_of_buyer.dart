import 'package:flutter/material.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/page/buyer/api/model/buyer_statictis_data.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class LastestOrderOfBuyer extends StatelessWidget {
  const LastestOrderOfBuyer({
    super.key,
    required this.buyerDetail,
  });

  final BuyerStatictisData buyerDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '3 đơn gần nhất',
                style: headStyleLargeBlackLigh,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = buyerDetail.packageDataResponses[index];
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: bigRoundBorderRadius, color: White),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: formatLocalDateTime(item.createat),
                              style: customerNameBig400.copyWith(color: Black),
                              children: [
                                TextSpan(text: ' - '),
                                TextSpan(
                                  text: item.getID,
                                  style: customerNameBigHigh400,
                                ),
                              ],
                            ),
                          ),
                          TextRound(
                            txt: item.getStatusTxt(),
                            isHigh: item.isDone,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Divider(),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            '${item.items.length} SP:',
                            style: customerNameBig400,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          if (item.items.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                  color: BackgroundColor,
                                  borderRadius: bigRoundBorderRadius),
                              child: Text(
                                  'x${item.items[0].numberUnit} ${item.items[0].get_show_name}'),
                            ),
                          SizedBox(
                            width: 8,
                          ),
                          if (item.items.length > 1)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                  color: BackgroundColor,
                                  borderRadius: bigRoundBorderRadius),
                              child: Text('+${item.items.length - 1}'),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng cộng',
                            style: headStyleBigMediumBlackLight,
                          ),
                          Text(
                            item.finalPriceFormat,
                            style: headStyleSemiLarge600,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: buyerDetail.packageDataResponses.length),
        ],
      ),
    );
  }
}

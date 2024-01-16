import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ReportMainInfo extends StatelessWidget {
  const ReportMainInfo({
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

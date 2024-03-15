import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class ReportBenifitMainInfo extends StatelessWidget {
  const ReportBenifitMainInfo({
    super.key,
    required this.totalSellingMoney,
    required this.totalSellingCost,
    required this.totalIncomeMoney,
    required this.totalOutComeMoney,
  });

  final double totalSellingMoney;
  final double totalSellingCost;

  final double totalIncomeMoney;
  final double totalOutComeMoney;

  @override
  Widget build(BuildContext context) {
    final benifit = totalIncomeMoney -
        totalOutComeMoney +
        totalSellingMoney -
        totalSellingCost;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 12),
      decoration: BoxDecoration(
        boxShadow: [defaultShadow],
        borderRadius: bigRoundBorderRadius,
        color: White,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  _ReportIteam(
                    title: 'Doanh thu',
                    value: MoneyFormater.format(totalSellingMoney),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  _ReportIteam(
                    title: 'Khoảng thu',
                    value: MoneyFormater.format(totalIncomeMoney),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    '-',
                    style: customerNameBig600,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    '-',
                    style: customerNameBig600,
                  ),
                ],
              ),
              Column(
                children: [
                  _ReportIteam(
                    title: 'Phí bán hàng',
                    value: MoneyFormater.format(totalSellingCost),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _ReportIteam(
                    title: 'Khoảng chi',
                    value: MoneyFormater.format(totalOutComeMoney),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    '=',
                    style: customerNameBig600,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    '=',
                    style: customerNameBig600,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _ReportIteam(
                    title: 'Lợi nhuận gộp',
                    value: MoneyFormater.format(
                        totalSellingMoney - totalSellingCost),
                    isAlignLeft: true,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  const Text(
                    '+',
                    style: customerNameBig600,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  _ReportIteam(
                    title: 'số dư',
                    value: MoneyFormater.format(
                        totalIncomeMoney - totalOutComeMoney),
                    isAlignLeft: true,
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Black15,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Lợi nhuận',
                    style: headStyleMediumWhiteSuperLight500,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    MoneyFormater.format(benifit),
                    style: benifit > 0
                        ? headStyleXLargeSemiBoldProfit
                        : headStyleXLargeSemiBoldCost,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportIteam extends StatelessWidget {
  final String title;
  final String value;
  final bool isAlignLeft;
  const _ReportIteam({
    super.key,
    required this.title,
    required this.value,
    this.isAlignLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isAlignLeft ? CrossAxisAlignment.end : CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: headStyleMediumWhiteSuperLight500,
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: customerNameBig600,
        ),
      ],
    );
  }
}

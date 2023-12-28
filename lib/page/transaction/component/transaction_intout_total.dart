import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class InOutTotal extends StatelessWidget {
  final bool isIncome;
  final String txt;
  const InOutTotal({
    super.key,
    required this.isIncome,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: isIncome ? TableHighColor : Red,
          radius: 22.5,
          child: LoadSvg(
              assetPath: isIncome ? 'svg/income.svg' : 'svg/outcome.svg'),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isIncome ? 'Tổng thu:' : 'Tổng chi:',
                style: headStyleMediumWhiteLigh500,
              ),
              SizedBox(
                height: 3,
              ),
              Tooltip(
                message: txt,
                triggerMode: TooltipTriggerMode.tap,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  txt,
                  style: totalMoneyStylexxXLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

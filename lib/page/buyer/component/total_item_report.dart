import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class TotalReportItem extends StatelessWidget {
  const TotalReportItem({
    super.key,
    required this.contentTxt,
    required this.iconPath,
    required this.headerTxt,
    this.bgColor = BackgroundColor,
    this.unLimitHeader = false,
  });

  final String contentTxt;
  final String iconPath;
  final String headerTxt;
  final Color bgColor;
  final bool unLimitHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration:
          BoxDecoration(borderRadius: bigRoundBorderRadius, color: bgColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadSvg(assetPath: iconPath),
              const SizedBox(
                width: 9,
              ),
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: unLimitHeader ? 1000 : 120),
                child: Text(
                  headerTxt,
                  overflow: TextOverflow.ellipsis,
                  style: headStyleLargeBlackLigh,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            contentTxt,
            style: headStyleXLargeSemiBold,
          ),
        ],
      ),
    );
  }
}
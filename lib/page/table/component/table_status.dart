import 'package:flutter/material.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class TableStatus extends StatelessWidget {
  final ListAreDataResult data;
  const TableStatus({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var (inUsed, available) = data.getStatus;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                LoadSvg(assetPath: 'svg/table.svg'),
                SizedBox(
                  width: 19,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Còn trống: ',
                    style: subInfoStyLarge500,
                    children: [
                      TextSpan(
                          text: '$available', style: subInfoStyLarge600High)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 20,
              child: const VerticalDivider(
                width: 32,
              )),
          Expanded(
            child: Row(
              children: [
                LoadSvg(assetPath: 'svg/time.svg'),
                SizedBox(
                  width: 19,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Đang sử dụng: ',
                    style: subInfoStyLarge500,
                    children: [
                      TextSpan(text: '$inUsed', style: subInfoStyLarge600High)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

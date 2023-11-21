import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/switch_btn.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class TotalPrice extends StatelessWidget {
  final bool isEditting;
  const TotalPrice({
    super.key,
    required this.isEditting,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng 6 sản phẩm',
              style:
                  isEditting ? headStyleSemiLargeLigh500 : headStyleXLargeLigh,
            ),
            Text(
              '90.000',
              style: isEditting ? headStyleXLarge : headStyleXXLarge,
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Chiết khấu',
                  style: isEditting
                      ? headStyleSemiLargeLigh500
                      : headStyleXLargeLigh,
                ),
                SizedBox(
                  width: 18,
                ),
                SwitchBtn(
                  firstTxt: 'VND',
                  secondTxt: '%',
                  onChanged: (int) {},
                ),
              ],
            ),
            isEditting
                ? Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          initialValue: '30.000',
                          maxLines: 1,
                          style: headStyleXLargeHigh,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg')
                    ],
                  )
                : Text(
                    '0',
                    style: headStyleXXLarge,
                  ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Phí vận chuyển',
              style:
                  isEditting ? headStyleSemiLargeLigh500 : headStyleXLargeLigh,
            ),
            isEditting
                ? Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          initialValue: '30.000',
                          maxLines: 1,
                          style: headStyleXLargeHigh,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg')
                    ],
                  )
                : Text(
                    '0',
                    style: headStyleXXLarge,
                  ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Divider(
          color: Black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng cộng',
              style: totalMoneyHeaderStylexXLarge,
            ),
            Text(
              '90.000',
              style: totalMoneyStylexXLarge,
            ),
          ],
        ),
      ],
    ));
  }
}

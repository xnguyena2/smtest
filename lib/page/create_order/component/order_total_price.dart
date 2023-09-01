import 'package:flutter/material.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
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
              style: headStyleXLargeLigh,
            ),
            Text(
              '90.000',
              style: headStylexXLarge,
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
              style: headStyleXLargeLigh,
            ),
            Text(
              '0',
              style: headStylexXLarge,
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
              'Chiết khấu',
              style: headStyleXLargeLigh,
            ),
            Text(
              '0',
              style: headStylexXLarge,
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

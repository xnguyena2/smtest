import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class OrderMainInfo extends StatelessWidget {
  const OrderMainInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'ARPGRK',
                    style: headStyleXLarge400,
                  ),
                  SizedBox(
                    width: 8.5,
                  ),
                  LoadSvg(assetPath: 'svg/copy.svg', width: 15, height: 15)
                ],
              ),
              TextRound(txt: 'Đã giao', isHigh: true),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '16:49 - 01/08/2023',
            style: subStyleMediumNormalLight,
          ),
          SizedBox(
            height: 7,
          ),
          Divider(),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            decoration: BoxDecoration(
              color: BackgroundHigh,
              borderRadius: defaultSquareBorderRadius,
            ),
            child: Row(
              children: [
                Text(
                  'Khu vực 1 - bàn 1',
                  style: subInfoStyLarge500High,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '90.000',
                style: moneyStyleSuperLarge,
              ),
              ApproveBtn(
                txt: 'Gửi hóa đơn',
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Đã thanh toán',
            style: headStyleMediumHigh500,
          )
        ],
      ),
    );
  }
}

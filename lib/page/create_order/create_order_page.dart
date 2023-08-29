import 'package:flutter/material.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/page/create_order/component/create_order_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';

import '../../utils/constants.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CreateOrderBar(),
      body: Stack(children: [
        Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          color: BackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                OrderMainInfo(),
                SizedBox(
                  height: 15,
                ),
                CustomerInfo(),
                SizedBox(
                  height: 15,
                ),
                ListProduct(),
                SizedBox(
                  height: 15,
                ),
                TotalPrice(),
                SizedBox(
                  height: 15,
                ),
                Transaction(),
                SizedBox(
                  height: 15,
                ),
                Progress(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
              color: White,
              boxShadow: [wholeShadow],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: White,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: borderColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Hủy',
                      style: headStyleBigMedium,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: TableHighColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Đã giao',
                      style: headStyleBigMediumWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}

class Progress extends StatelessWidget {
  const Progress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: ProgressItem(
            isDone: true,
            isFirst: true,
            txt: 'Chờ xác nhận',
            subTxt: '16:08 14/08/2023',
          )),
          Expanded(
              child: ProgressItem(
            isDone: true,
            txt: 'Chờ xác nhận',
            subTxt: '16:08 14/08/2023',
          )),
          Expanded(
              child: ProgressItem(
            isDone: false,
            isLast: true,
            txt: 'Chờ xác nhận',
            subTxt: '16:08 14/08/2023',
          )),
        ],
      ),
    ));
  }
}

class ProgressItem extends StatelessWidget {
  final bool isDone;
  final String txt;
  final String subTxt;
  bool isFirst;
  bool isLast;
  ProgressItem({
    super.key,
    required this.isDone,
    required this.txt,
    required this.subTxt,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: isFirst
                    ? SizedBox()
                    : Divider(
                        color: HighColor,
                      )),
            isDone
                ? LoadSvg(assetPath: 'svg/check.svg')
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 5,
                    ),
                  ),
            Expanded(
                child: isLast
                    ? SizedBox()
                    : Divider(
                        color: HighColor,
                      ))
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          txt,
          style: headStyleMedium,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          subTxt,
          style: subInfoStyMedium400Light,
        ),
      ],
    );
  }
}

class Transaction extends StatelessWidget {
  const Transaction({
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
            TextRound(txt: 'Khách còn nợ', isHigh: false),
            Text(
              '25.000',
              style: subInfoStyLargeAlert600,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 40,
              child: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('02/08/2023'), Text('05:25')],
                ),
                SizedBox(
                  width: 15,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    VerticalDivider(),
                    CircleAvatar(
                      radius: 5,
                    )
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: BackgroundColor,
                      borderRadius: defaultBorderRadius),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tiền mặt',
                        style: headStyleMediumNormalLight,
                      ),
                      Text(
                        '90.000',
                        style: headStyleLargeHigh,
                      )
                    ],
                  ),
                ))
              ]),
            );
          },
          itemCount: 5,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}

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
          height: 12,
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

class ListProduct extends StatelessWidget {
  const ListProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        border: defaultBorder,
                        borderRadius: defaultSquareBorderRadius,
                        color: BackgroundColor),
                    child: Center(
                      child: LoadSvg(
                          assetPath: 'svg/product.svg', width: 20, height: 20),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mỳ hảo hảo',
                          style: headStyleXLarge,
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '15.000',
                        style: headStyleBigMediumBlackLight,
                      ),
                      Text(
                        'x6',
                        style: headStyleBigMedium,
                      ),
                      Text(
                        '90.000',
                        style: headStyleXLarge,
                      )
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              SizedBox(height: 15, child: Divider()),
          itemCount: 3),
    );
  }
}

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
      child: Column(
        children: [
          SizedBox(
            height: 11,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: borderColor,
                child: CircleAvatar(
                  backgroundColor: White,
                  radius: 24,
                  child: LoadSvg(assetPath: 'svg/profile_round.svg'),
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                'Khách lẻ',
                style: customerNameBig,
              ),
              SizedBox(
                width: 4,
              ),
              LoadSvg(assetPath: 'svg/copy.svg', width: 15, height: 15),
            ],
          ),
          SizedBox(
            height: 11,
          ),
        ],
      ),
    );
  }
}

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
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  backgroundColor: TableHighColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Gửi hóa đơn',
                  style: subInfoStyLargeWhite400,
                ),
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

class DefaultPaddingContainer extends StatelessWidget {
  final Widget child;
  const DefaultPaddingContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: child,
    );
  }
}

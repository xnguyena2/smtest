import 'package:flutter/material.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';

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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/transaction.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/constants.dart';

class Transaction extends StatelessWidget {
  const Transaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PackageDataResponse data = context.watch<ProductProvider>().getPackage!;
    double own = data.finalPrice - data.payment;
    String ownFormat = MoneyFormater.format(own);
    final transactions = data.progress?.transaction ?? [];
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (own > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextRound(txt: 'Khách còn nợ', isHigh: false),
              Row(
                children: [
                  Text(
                    ownFormat,
                    style: headStyleLargeRed,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                ],
              )
            ],
          )
        else
          Row(
            children: [
              TextRound(txt: 'Đã thanh toán', isHigh: true),
            ],
          ),
        if (transactions.length > 0) ...[
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TransactionItem(
                data: transactions[index],
              );
            },
            itemCount: transactions.length,
          ),
          SizedBox(
            height: 10,
          ),
        ]
      ],
    ));
  }
}

class TransactionItem extends StatelessWidget {
  final TransactionHistory data;
  const TransactionItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.localDateTxt),
            Text(data.localTimeTxt),
          ],
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
              color: BackgroundColor, borderRadius: defaultBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.type,
                style: headStyleMediumNormalLight,
              ),
              Text(
                MoneyFormater.format(data.payment),
                style: headStyleLargeHigh,
              )
            ],
          ),
        ))
      ]),
    );
  }
}

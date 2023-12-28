import 'package:flutter/material.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/page/transaction/component/modal_create_transaction.dart';
import 'package:sales_management/utils/constants.dart';

class TransactionDetail extends StatelessWidget {
  final PaymentTransaction data;
  const TransactionDetail({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool isIncome = data.transaction_type == TType.INCOME;
    return GestureDetector(
      onTap: () {
        showDefaultModal(
          context: context,
          content: ModalTransactionDetail(
            isIncome: isIncome,
            data: data,
          ),
        );
      },
      child: Container(
        color: White,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.category ?? 'unknow',
                  style: headStyleBigMediumBlackLight,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  data.onlyTime,
                  style: headStyleSemiLarge500,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${isIncome ? '+' : '-'}${MoneyFormater.format(data.amount)}',
                  style:
                      isIncome ? customerNameBigHigh600 : customerNameBigRed600,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  data.money_source ?? 'unknow',
                  style: subInfoStyLargeLigh400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

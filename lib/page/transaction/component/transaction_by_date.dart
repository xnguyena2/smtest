import 'package:flutter/material.dart';
import 'package:sales_management/page/transaction/api/model/list_payment_transaction.dart';
import 'package:sales_management/utils/constants.dart';

class TransactionByDate extends StatelessWidget {
  final TransactionByDateOfMonthWithOffset transaction;
  const TransactionByDate({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Color(0xFFE0E0E0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                transaction.dateInWeek,
                style: headStyleXLargeSemiBold,
              ),
              Text(
                transaction.date,
                style: headStyleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: Red,
                ),
                child: Text(
                  MoneyFormater.format(transaction.totalOutCome),
                  style: customerNameBigWhite600,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: TableHighColor,
                ),
                child: Text(
                  MoneyFormater.format(transaction.totalIncome),
                  style: customerNameBigWhite600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

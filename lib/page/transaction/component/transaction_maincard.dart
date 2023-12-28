import 'package:flutter/material.dart';
import 'package:sales_management/page/transaction/api/model/list_payment_transaction.dart';
import 'package:sales_management/page/transaction/component/transaction_intout_total.dart';
import 'package:sales_management/utils/constants.dart';

class MainCard extends StatelessWidget {
  final ListPaymentTransactionDataResult data;
  const MainCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        gradient: LinearGradient(
          colors: [
            Color(0xFF42224A),
            Color(0xCE42224A),
          ],
          begin: Alignment.centerLeft,
          end: Alignment(1.2, -1.0),
          transform: GradientRotation(1.48353),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 11,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: defaultBorderRadius,
              color: Color(0xFF42224A),
            ),
            child: Text(
              'Số dư',
              style: headStyleLargeWhiteLigh,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            MoneyFormater.format(data.balance),
            style: totalMoneyStylexXXLargeWhite,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InOutTotal(
                  isIncome: false,
                  txt: MoneyFormater.format(data.totalOutCome),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: InOutTotal(
                  isIncome: true,
                  txt: MoneyFormater.format(data.totalIncome),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

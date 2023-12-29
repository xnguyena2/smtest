import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/page/transaction/api/model/list_payment_transaction.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/page/transaction/api/transaction_api.dart';
import 'package:sales_management/page/transaction/component/income_outcome_bar.dart';
import 'package:sales_management/page/transaction/component/transaction_list.dart';
import 'package:sales_management/page/transaction/component/transaction_maincard.dart';
import 'package:sales_management/page/transaction_create/transaction_create.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class IncomeOutComme extends StatelessWidget {
  const IncomeOutComme({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: IncomeOutComeBar(),
        body: FetchAPI<ListPaymentTransactionDataResult>(
          future: getTransactionsReportOfCurrentMonthByDate(),
          successBuilder: (listPaymentTransactionDataResult) {
            if (listPaymentTransactionDataResult.listResult.isEmpty) {
              return Center(
                child: HighBorderContainer(
                  isHight: true,
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Chưa có khoản thu/chi nào!!',
                        style: headStyleSemiLargeHigh500,
                      ),
                    ],
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainCard(
                    data: listPaymentTransactionDataResult,
                  ),
                  ListTransaction(
                    data: listPaymentTransactionDataResult,
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomBar(
          headOkbtn: LoadSvg(assetPath: 'svg/plus_circle.svg'),
          okBtnTxt: 'Khoảng thu',
          headCancelbtn: LoadSvg(assetPath: 'svg/minus_circle.svg'),
          cancelBtnTxt: 'Khoảng chi',
          enableDelete: true,
          done: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionCreate(
                  transaction: PaymentTransaction.empty(TType.INCOME),
                  onUpdated: (PaymentTransaction) {},
                ),
              ),
            );
          },
          cancel: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionCreate(
                  transaction: PaymentTransaction.empty(TType.OUTCOME),
                  onUpdated: (PaymentTransaction) {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

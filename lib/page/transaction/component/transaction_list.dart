import 'package:flutter/material.dart';
import 'package:sales_management/component/expand/app_expansion_panel.dart';
import 'package:sales_management/page/transaction/api/model/list_payment_transaction.dart';
import 'package:sales_management/page/transaction/component/transaction_by_date.dart';
import 'package:sales_management/page/transaction/component/transaction_item_detail.dart';
import 'package:sales_management/utils/constants.dart';

class ListTransaction extends StatefulWidget {
  final ListPaymentTransactionDataResult data;
  const ListTransaction({
    super.key,
    required this.data,
  });

  @override
  State<ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  late List<_WrapExpandTransaction> data = widget.data.listResultFlat
      .map((e) => _WrapExpandTransaction(transaction: e))
      .toList();
  @override
  Widget build(BuildContext context) {
    return AppExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: White,
      expansionCallback: (panelIndex, isExpanded) {
        data[panelIndex].isExpanded = !isExpanded;
        setState(() {});
      },
      children: data
          .map(
            (e) => ExpansionPanel(
              isExpanded: e.isExpanded,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return TransactionByDate(
                  transaction: e.transaction,
                );
              },
              body: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TransactionDetail(
                    data: e.transaction.transactions[index],
                    onUpdated: (PaymentTransaction) {
                      widget.data.updateTransaction(PaymentTransaction);
                      data = widget.data.listResultFlat
                          .map((e) => _WrapExpandTransaction(transaction: e))
                          .toList();
                      setState(() {});
                    },
                  );
                },
                scrollDirection: Axis.vertical,
                itemCount: e.transaction.transactions.length,
                separatorBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Divider(
                    color: Black40,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _WrapExpandTransaction {
  final TransactionByDateOfMonthWithOffset transaction;
  bool isExpanded = true;

  _WrapExpandTransaction({required this.transaction});
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/component/expand/app_expansion_panel.dart';
import 'package:sales_management/page/transaction/api/model/list_payment_transaction.dart';
import 'package:sales_management/page/transaction/component/transaction_by_date.dart';
import 'package:sales_management/page/transaction/component/transaction_item_detail.dart';
import 'package:sales_management/utils/constants.dart';

import 'transaction_provider.dart';

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
  late List<TransactionByDateOfMonthWithOffset> data =
      widget.data.listResultFlat;
  late Map<int, bool> expanedStatus = Map.fromEntries(data.map(
    (e) => MapEntry(e.timeStamp, true),
  ));

  void updateExpanedStatus() {
    Map<int, bool> newMap = Map();
    data.forEach((element) {
      var status = expanedStatus[element.timeStamp];
      newMap[element.timeStamp] = status ?? true;
    });
    expanedStatus = newMap;
  }

  @override
  Widget build(BuildContext context) {
    return AppExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: White,
      expansionCallback: (panelIndex, isExpanded) {
        expanedStatus[data[panelIndex].timeStamp] = !isExpanded;
        setState(() {});
      },
      children: data
          .map(
            (e) => ExpansionPanel(
              isExpanded: expanedStatus[e.timeStamp] ?? true,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return TransactionByDate(
                  transaction: e,
                );
              },
              body: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TransactionDetail(
                    data: e.transactions[index],
                    onUpdated: (PaymentTransaction) {
                      // widget.data.updateTransaction(PaymentTransaction);
                      context.read<TransactionProvider>().updateValue =
                          PaymentTransaction;
                      data = widget.data.listResultFlat;
                      updateExpanedStatus();
                      // setState(() {});
                    },
                    onDeleted: (PaymentTransaction) {
                      widget.data.deleteTransaction(PaymentTransaction);
                      context.read<TransactionProvider>().justRefresh();
                      data = widget.data.listResultFlat;
                      updateExpanedStatus();
                    },
                  );
                },
                scrollDirection: Axis.vertical,
                itemCount: e.transactions.length,
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

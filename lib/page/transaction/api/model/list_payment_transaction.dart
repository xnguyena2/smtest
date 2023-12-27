import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/utils/utils.dart';

class ListPaymentTransactionDataResult {
  ListPaymentTransactionDataResult({
    required this.listResult,
  });
  late final List<PaymentTransaction> listResult;
  late final List<TransactionByDateOfMonthWithOffset> listResultFlat;

  ListPaymentTransactionDataResult.fromJson(Map<String, dynamic> json) {
    listResult = json['list_result'] == null
        ? []
        : List.from(json['list_result'])
            .map((e) => PaymentTransaction.fromJson(e))
            .toList();
  }

  int firstDate = 0;
  int lastDate = 0;

  double totalIncome = 0;
  double totalOutCome = 0;
  double balance = 0;

  void fillAllEmpty(String from, String to) {
    firstDate = extractTimeStamp(from);
    lastDate = extractTimeStamp(to);

    print('firstDate: $firstDate, lastDate: $lastDate');

    Map<int, TransactionByDateOfMonthWithOffset> resultMaped =
        Map<int, TransactionByDateOfMonthWithOffset>();

    listResult.forEach((element) {
      if (element.transaction_type == TType.INCOME) {
        totalIncome += element.amount;
      }
      if (element.transaction_type == TType.OUTCOME) {
        totalOutCome += element.amount;
      }
      int ts =
          element.createat == null ? 0 : extractTimeStamp(element.createat!);
      var currentDate = resultMaped[ts];
      if (currentDate == null) {
        resultMaped[ts] =
            TransactionByDateOfMonthWithOffset(0, ts, transaction: element);
      } else {
        currentDate.addTransaction(element);
      }
    });
    balance = totalIncome - totalOutCome;
    int offset = 0;
    for (int i = firstDate; i <= lastDate; i += 86400000) {
      var p = resultMaped[i];
      if (p == null) {
        resultMaped[i] = TransactionByDateOfMonthWithOffset(
          offset,
          i,
          transaction: null,
        );
      } else {
        p.offset = offset;
      }
      offset++;
    }

    listResultFlat = resultMaped.values.toList();
    listResultFlat.sort(
      (a, b) => a.offset.compareTo(b.offset),
    );
  }

  int getTimeStampFrom({required int offset}) {
    return firstDate + offset * 86400000;
  }
}

class TransactionByDateOfMonthWithOffset {
  double totalIncome = 0;
  double totalOutCome = 0;
  late String dateInWeek;

  late final List<PaymentTransaction> transactions;
  int offset;
  final int timeStamp;

  TransactionByDateOfMonthWithOffset(this.offset, this.timeStamp,
      {required PaymentTransaction? transaction}) {
    if (transaction?.transaction_type == TType.INCOME) {
      totalIncome += transaction?.amount ?? 0;
    }
    if (transaction?.transaction_type == TType.INCOME) {
      totalOutCome += transaction?.amount ?? 0;
    }
    transactions = transaction == null ? [] : [transaction];
    dateInWeek = transaction?.createat == null
        ? ''
        : getDateinWeekofTimeStamp(transaction?.createat ?? '');
  }

  void addTransaction(PaymentTransaction transaction) {
    if (transaction.transaction_type == TType.INCOME) {
      totalIncome += transaction.amount;
    }
    if (transaction.transaction_type == TType.INCOME) {
      totalOutCome += transaction.amount;
    }
    transactions.add(transaction);
  }
}

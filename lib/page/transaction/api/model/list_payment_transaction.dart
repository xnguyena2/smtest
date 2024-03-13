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

  void calcData() {
    Map<int, TransactionByDateOfMonthWithOffset> resultMaped =
        <int, TransactionByDateOfMonthWithOffset>{};

    listResult.forEach((element) {
      if (element.transaction_type == TType.INCOME) {
        totalIncome += element.amount;
      }
      if (element.transaction_type == TType.OUTCOME) {
        totalOutCome += element.amount;
      }
      int ts = element.createat == null
          ? 0
          : extractOnlyDateTimeStampToLocal(element.createat!);
      var currentDate = resultMaped[ts];
      if (currentDate == null) {
        resultMaped[ts] =
            TransactionByDateOfMonthWithOffset(0, ts, transaction: element);
      } else {
        currentDate.addTransaction(element);
      }
    });
    balance = totalIncome - totalOutCome;

    listResultFlat = resultMaped.values.toList();
    listResultFlat.sort(
      (a, b) => b.timeStamp.compareTo(a.timeStamp),
    );
    listResultFlat.forEach((element) {
      element.sort();
    });
  }

  void fillAllEmpty(String from, String to) {
    firstDate = extractTimeStamp(from);
    lastDate = extractTimeStamp(to);

    Map<int, TransactionByDateOfMonthWithOffset> resultMaped =
        Map<int, TransactionByDateOfMonthWithOffset>();

    listResult.forEach((element) {
      if (element.transaction_type == TType.INCOME) {
        totalIncome += element.amount;
      }
      if (element.transaction_type == TType.OUTCOME) {
        totalOutCome += element.amount;
      }
      int ts = element.createat == null
          ? 0
          : extractOnlyDateTimeStampToLocal(element.createat!);
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

  void updateTotalValue() {
    totalIncome = 0;
    totalOutCome = 0;
    listResult.forEach((element) {
      if (element.transaction_type == TType.INCOME) {
        totalIncome += element.amount;
      }
      if (element.transaction_type == TType.OUTCOME) {
        totalOutCome += element.amount;
      }
    });
    balance = totalIncome - totalOutCome;
  }

  void deleteTransaction(PaymentTransaction transaction) {
    int index = listResult.indexWhere((element) =>
        element.transaction_second_id == transaction.transaction_second_id);
    if (index < 0) {
      return;
    }
    var old_transaction = listResult[index];
    listResult.removeAt(index);
    removePlatlistTransaction(transaction, old_transaction);
    updateTotalValue();
  }

  void updateTransaction(PaymentTransaction transaction) {
    int new_ts = transaction.createat == null
        ? 0
        : extractOnlyDateTimeStampToLocal(transaction.createat!);
    int index = listResult.indexWhere((element) =>
        element.transaction_second_id == transaction.transaction_second_id);
    if (index >= 0) {
      var old_transaction = listResult[index];
      listResult[index] = transaction;
      removePlatlistTransaction(transaction, old_transaction);
      updatePlatlistTransaction(new_ts, transaction);
      return;
    }

    listResult.add(transaction);
    updatePlatlistTransaction(new_ts, transaction);
    return;
  }

  void removePlatlistTransaction(
      PaymentTransaction transaction, PaymentTransaction oldTransaction) {
    int old_ts = oldTransaction.createat == null
        ? 0
        : extractOnlyDateTimeStampToLocal(oldTransaction.createat!);
    TransactionByDateOfMonthWithOffset? ListTransaction = null;
    for (var element in listResultFlat) {
      if (element.timeStamp == old_ts) {
        element.removeTransaction(oldTransaction);
        if (element.transactions.isEmpty) {
          ListTransaction = element;
          break;
        }
      }
    }
    if (ListTransaction != null) {
      listResultFlat.remove(ListTransaction);
    }
  }

  void updatePlatlistTransaction(int new_ts, PaymentTransaction transaction) {
    int index =
        listResultFlat.indexWhere((element) => element.timeStamp == new_ts);
    if (index < 0) {
      listResultFlat.add(TransactionByDateOfMonthWithOffset(0, new_ts,
          transaction: transaction));
      listResultFlat.sort(
        (a, b) => b.timeStamp.compareTo(a.timeStamp),
      );
      updateTotalValue();
      return;
    }
    listResultFlat[index].addTransaction(transaction);
    listResultFlat[index].sort();
    updateTotalValue();
  }
}

class TransactionByDateOfMonthWithOffset {
  double totalIncome = 0;
  double totalOutCome = 0;
  late String dateInWeek;

  late final List<PaymentTransaction> transactions;
  int offset;
  final int timeStamp;
  late final String date;

  TransactionByDateOfMonthWithOffset(this.offset, this.timeStamp,
      {required PaymentTransaction? transaction}) {
    if (transaction?.transaction_type == TType.INCOME) {
      totalIncome += transaction?.amount ?? 0;
    }
    if (transaction?.transaction_type == TType.OUTCOME) {
      totalOutCome += transaction?.amount ?? 0;
    }
    transactions = transaction == null ? [] : [transaction];
    dateInWeek = transaction?.createat == null
        ? ''
        : getDateinWeekofTimeStampToLocal(transaction?.createat ?? '');
    date = transaction?.createat == null
        ? ''
        : formatLocalDateTimeOnlyDateSplash(transaction?.createat ?? '');
  }

  void addTransaction(PaymentTransaction transaction) {
    if (transaction.transaction_type == TType.INCOME) {
      totalIncome += transaction.amount;
    }
    if (transaction.transaction_type == TType.OUTCOME) {
      totalOutCome += transaction.amount;
    }
    transactions.add(transaction);
  }

  void removeTransaction(PaymentTransaction transaction) {
    bool success = transactions.remove(transaction);
    if (!success) {
      return;
    }
    if (transaction.transaction_type == TType.INCOME) {
      totalIncome -= transaction.amount;
    }
    if (transaction.transaction_type == TType.OUTCOME) {
      totalOutCome -= transaction.amount;
    }
  }

  void sort() {
    transactions.sort(
      (a, b) => b.onlyTime.compareTo(a.onlyTime),
    );
  }
}

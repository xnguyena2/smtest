import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';

class TransactionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  TransactionProvider();

  PaymentTransaction? _transaction;

  PaymentTransaction? get getData => _transaction;

  set updateValue(PaymentTransaction data) {
    _transaction = data;
    notifyListeners();
  }

  void justRefresh() {
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('_transaction', _transaction));
  }
}

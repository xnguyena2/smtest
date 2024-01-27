import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DiscountProvider with ChangeNotifier, DiagnosticableTreeMixin {
  DiscountProvider(double? data) : _discount = data;

  double? _discount;

  double? get getDiscount => _discount;

  set updateValue(double data) {
    _discount = data;
    notifyListeners();
  }

  void clean() {
    _discount = 0;
  }

  void justRefresh() {
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('_discount', _discount));
  }
}

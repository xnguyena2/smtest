import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';

class PriceProvider with ChangeNotifier, DiagnosticableTreeMixin {
  PriceProvider(PackageDataResponse data) : _package = data;

  PackageDataResponse? _package;

  PackageDataResponse? get getPackage => _package;

  set updateValue(PackageDataResponse data) {
    _package = data;
    notifyListeners();
  }

  void justRefresh() {
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('_package', _package));
  }
}

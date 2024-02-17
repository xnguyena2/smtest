import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';

class NewOrderProvider with ChangeNotifier, DiagnosticableTreeMixin {
  NewOrderProvider();

  ListPackageDetailResult? _data;

  ListPackageDetailResult get getData =>
      _data ?? ListPackageDetailResult(listResult: []);

  void clean() {
    _data?.listResult.clear();
    _data = null;
  }

  set updateValue(List<PackageDataResponse> data) {
    _data?.updateListOrder(data);
    notifyListeners();
  }

  set setValue(ListPackageDetailResult data) {
    _data = data;
    // notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('_data', _data));
  }
}

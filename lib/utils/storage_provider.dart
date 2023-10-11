import 'package:flutter/foundation.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';

class StorageProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<AreaData>? _list_area;

  List<AreaData>? get listAreaData => _list_area;

  void set setListArea(List<AreaData> data) => _list_area = data;

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('_list_area', _list_area));
  }
}

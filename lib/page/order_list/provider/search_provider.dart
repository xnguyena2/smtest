import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier, DiagnosticableTreeMixin {
  SearchProvider(String data) : _txt = data;

  String? _txt;

  String? get getTxt => _txt;

  set updateValue(String data) {
    _txt = data;
    notifyListeners();
  }

  void justRefresh() {
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('_txt', _txt));
  }
}

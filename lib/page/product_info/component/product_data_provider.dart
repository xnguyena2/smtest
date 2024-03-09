import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';

class ProductDataProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ProductDataProvider({required this.beerSubmitData});

  BeerSubmitData beerSubmitData;

  BeerSubmitData get getData => beerSubmitData;

  set updateValue(BeerSubmitData data) {
    beerSubmitData = data;
    notifyListeners();
  }

  void justRefresh() {
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('_beerSubmitData', beerSubmitData));
  }
}

import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';

List<BeerSubmitData>? getAllProduct() {
  BootStrapData? config = LocalStorage.getBootStrap();
  if (config == null) {
    return null;
  }
  return config.products;
}

Map<String, BeerUnit> getMapUnit() {
  Map<String, BeerUnit> mapUni = {};
  final listAllProduct = getAllProduct();
  if (listAllProduct != null) {
    for (var element in listAllProduct!) {
      final listUnit = element.listUnit;
      if (listUnit == null) {
        continue;
      }
      for (var e in listUnit) {
        if (!mapUni.containsKey(e.beerUnitSecondId)) {
          mapUni[e.beerUnitSecondId] = e;
        }
      }
    }
  }
  return mapUni;
}

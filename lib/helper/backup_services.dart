import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/helper/local_query.dart';

class BackUpServices {
  List<BeerSubmitData>? listAllProduct;

  BackUpServices({this.listAllProduct});

  final Map<String, int> inventoryImg = {};

  bool isShouldRestoreFromBackup = true;

  void enableRestore(bool isEnable) {
    isShouldRestoreFromBackup = isEnable;
  }

  void backupInventoryNum() {
    // inventoryImg.clear();
    listAllProduct ??= getAllProduct();
    if (listAllProduct == null) {
      return;
    }
    for (var element in listAllProduct!) {
      final listUnit = element.listUnit;
      if (listUnit == null) {
        continue;
      }
      for (var e in listUnit) {
        if (!inventoryImg.containsKey(e.beerUnitSecondId)) {
          inventoryImg[e.beerUnitSecondId] = e.getInventoryNo;
        }
      }
    }
  }

  void restore() {
    if (listAllProduct == null || !isShouldRestoreFromBackup) {
      return;
    }
    for (var element in listAllProduct!) {
      final listUnit = element.listUnit;
      if (listUnit == null) {
        continue;
      }
      for (var e in listUnit) {
        final inventory_number = inventoryImg[e.beerUnitSecondId];
        if (inventory_number == null) {
          continue;
        }
        e.inventory_number = inventory_number;
      }
    }
  }
}

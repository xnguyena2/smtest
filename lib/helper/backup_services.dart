import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';

class BackUpServices {
  List<BeerSubmitData>? listAllProduct;

  BackUpServices({this.listAllProduct});

  final Map<String, int> inventoryImg = {};

  bool isShouldRestoreFromBackup = true;

  List<BeerSubmitData>? _getAllProduct() {
    BootStrapData? config = LocalStorage.getBootStrap();
    if (config == null) {
      return null;
    }
    return config.products;
  }

  void enableRestore(bool isEnable) {
    isShouldRestoreFromBackup = isEnable;
  }

  void backupInventoryNum() {
    // inventoryImg.clear();
    listAllProduct ??= _getAllProduct();
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
    if (listAllProduct == null && !isShouldRestoreFromBackup) {
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

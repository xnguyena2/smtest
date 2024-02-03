import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/utils/constants.dart';

Future<Store?> getStoreInfo() async {
  BootStrapData? config = LocalStorage.getBootStrap();
  if (config == null) {
    return null;
  }

  return config.store;
}

void updateStoreData(Store store) {
  BootStrapData? config = LocalStorage.getBootStrap();
  config?.store = store;
  LocalStorage.setBootstrapData(config);
  setGlobalValue(
      store_ame: store.name,
      groupId: groupID,
      phoneNumber: store.phone ?? '',
      device_id: deviceID);
}

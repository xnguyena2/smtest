import 'package:intl/intl.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';

class PackageResult {
  PackageResult({
    required this.listResult,
  });
  late final List<PackageItem> listResult;

  PackageResult.fromJson(Map<String, dynamic> json) {
    listResult = List.from(json['list_result'])
        .map((e) => PackageItem.fromJson(e))
        .toList();
  }

  int calcTotal() {
    return listResult.fold(
        0, (previousValue, element) => previousValue + element.numberUnit);
  }

  void sort() {
    listResult.sort(
      (a, b) =>
          stringToDateTime(b.createat).compareTo(stringToDateTime(a.createat)),
    );
  }

  DateTime stringToDateTime(String dateValue) {
    return DateFormat("y-MM-ddThh:mm:ss.sssZ").parse(dateValue);
  }

  double totalPrice() {
    return listResult.fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            element.numberUnit *
                (element.beerSubmitData.listUnit?[0].price ?? 0) *
                (1 -
                    (element.beerSubmitData.listUnit?[0].discount ?? 0) / 100));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['list_result'] = listResult.map((e) => e.toJson()).toList();
    return _data;
  }
}

class PackageItem {
  PackageItem({
    required this.groupId,
    required this.createat,
    required this.deviceId,
    required this.productSecondId,
    required this.productUnitSecondId,
    required this.numberUnit,
    required this.status,
    required this.beerSubmitData,
  });
  late final String groupId;
  late final String createat;
  late final String deviceId;
  late final String productSecondId;
  late final String productUnitSecondId;
  late final int numberUnit;
  late final String? status;
  late final BeerSubmitData beerSubmitData;

  PackageItem.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    createat = json['createat'];
    deviceId = json['device_id'];
    productSecondId = json['product_second_id'];
    productUnitSecondId = json['product_unit_second_id'];
    numberUnit = json['number_unit'];
    status = json['status'];
    beerSubmitData = BeerSubmitData.fromJson(json['beerSubmitData']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['createat'] = createat;
    _data['device_id'] = deviceId;
    _data['product_second_id'] = productSecondId;
    _data['product_unit_second_id'] = productUnitSecondId;
    _data['number_unit'] = numberUnit;
    _data['status'] = status;
    _data['beerSubmitData'] = beerSubmitData.toJson();
    return _data;
  }
}

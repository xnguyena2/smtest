import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/product_unit_cat_pattern.dart';
import 'package:sales_management/api/model/result_interface.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/enum_by_name_or_null.dart';
import 'package:sales_management/utils/utils.dart';

part 'beer_submit_data.g.dart';

enum ProductUnitStatus {
  AVARIABLE,
  NOT_FOR_SELL,
  SOLD_OUT,
}

@HiveType(typeId: 2)
class BeerSubmitData extends BaseEntity implements ResultInterface {
  BeerSubmitData({
    super.id,
    required super.groupId,
    super.createat,
    required this.beerSecondID,
    required this.name,
    this.detail,
    required this.category,
    required this.status,
    this.meta_search,
    required this.images,
    required this.listUnit,
    required this.list_categorys,
    required this.unit_category_config,
  }) : productUnitCatPattern =
            ProductUnitCatPattern.fromJsonString(unit_category_config);

  @HiveField(4)
  late final String beerSecondID;

  @HiveField(5)
  late String name;

  @HiveField(6)
  late String? detail;

  @HiveField(7)
  late String category;

  @HiveField(8)
  late String status;

  @HiveField(9)
  late final String? meta_search;

  @HiveField(10)
  late List<Images> images;

  @HiveField(11)
  late List<BeerUnit>? listUnit;

  @HiveField(12)
  late List<String>? list_categorys;

  @HiveField(15)
  late final String? unit_category_config;

  BeerSubmitData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    beerSecondID = json['beerSecondID'];
    name = json['name'];
    detail = json['detail'];
    category = json['category'];
    unit_category_config = json['unit_category_config'];
    meta_search = json['meta_search'];
    status = json['status'];
    images = json['images'] == null
        ? []
        : List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    listUnit =
        List.from(json['listUnit']).map((e) => BeerUnit.fromJson(e)).toList();

    list_categorys = toListCat(category);
    productUnitCatPattern =
        ProductUnitCatPattern.fromJsonString(unit_category_config);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['group_id'] = groupId;
    _data['beerSecondID'] = beerSecondID;
    _data['name'] = name;
    _data['detail'] = detail;
    _data['category'] = category;
    _data['unit_category_config'] = productUnitCatPattern.toJsonString();
    _data['meta_search'] = meta_search;
    _data['status'] = status;
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['listUnit'] = listUnit?.map((e) => e.toJson()).toList();
    return _data;
  }

  BeerSubmitData clone() {
    return BeerSubmitData.fromJson(toJson());
  }

  BeerSubmitData cloneMainDataWithoutUnitCatConfig(BeerUnit? unit) {
    return BeerSubmitData(
      groupId: groupId,
      beerSecondID: beerSecondID,
      name: name,
      category: category,
      status: status,
      detail: detail,
      images: images,
      listUnit: unit != null ? [unit] : null,
      meta_search: meta_search,
      list_categorys: list_categorys,
      unit_category_config: null,
    );
  }

  factory BeerSubmitData.createEmpty(String groupID) {
    final productID = generateUUID();
    return BeerSubmitData(
      groupId: groupID,
      beerSecondID: productID,
      name: '',
      category: '',
      status: 'AVARIABLE',
      listUnit: [BeerUnit.empty(groupID, productID, '', null)],
      list_categorys: [],
      images: [],
      unit_category_config: '',
    );
  }

  late ProductUnitCatPattern productUnitCatPattern;

  void setUnitCat(ProductUnitCatPattern productUnitCatPattern) {
    this.productUnitCatPattern = productUnitCatPattern;
    listUnit ??= [];
    final firstUnit = firstOrNull;
    final oldUnitID =
        Map.fromEntries(listUnit!.map((e) => MapEntry(e.beerUnitSecondId, e)));
    final newUnitID = productUnitCatPattern.rebuildTree();
    List<BeerUnit> tempListUnit = [];
    newUnitID.forEach((element) {
      final name = element.name;
      final unit = oldUnitID[element.id];
      final newUnit = unit?.updatename(name) ??
          BeerUnit.empty(groupId, beerSecondID, name, element.id);
      tempListUnit.add(newUnit);
    });
    listUnit = tempListUnit;
    if (listUnit!.isEmpty) {
      listUnit = [firstUnit ?? BeerUnit.empty(groupId, beerSecondID, '', null)];
    }
  }

  void setListUnit(List<BeerUnit> listU) {
    listUnit = listU;
  }

  String get get_show_name =>
      '$name(${firstOrNull?.name ?? 'Removed'})'.replaceAll('()', '');

  void copyImg(BeerSubmitData oldProduct) {
    images.clear();
    images.addAll(oldProduct.images);
  }

  List<String> toListCat(String? cats) {
    if (cats == null) return [];
    final result = cats.split('<<CAT>>');
    result.removeWhere((element) => element.isEmpty);
    return result;
  }

  String toListCatTxt(List<String> cats) {
    cats.removeWhere((element) => element.isEmpty);
    return cats.join('<<CAT>>');
  }

  void updateListCat(List<String> cats) {
    list_categorys = cats;
    category = toListCatTxt(cats);
  }

  List<BeerSubmitData> flatUnit() {
    return listUnit == null
        ? [this]
        : listUnit!.map((e) => cloneMainDataWithoutUnitCatConfig(e)).toList();
  }

  BeerUnit? get firstOrNull => listUnit?.firstOrNull;

  bool get isHaveMultiCategory => productUnitCatPattern.items.isNotEmpty;

  String? get getFristLargeImg => images.firstOrNull?.medium;

  double get getRealPrice => firstOrNull?.realPrice ?? 0;

  double get getBuyPrice => firstOrNull?.buyPrice ?? 0;

  set setBuyPrice(double buyPrice) => firstOrNull?.buyPrice = buyPrice;

  double get getPrice => firstOrNull?.price ?? 0;

  set setPrice(double price) => firstOrNull?.price = price;

  double get getPromotionPrice => firstOrNull?.promotional_price ?? 0;

  set setPromotionPrice(double promotionPrice) =>
      firstOrNull?.promotional_price = promotionPrice;

  double get getWholesalePrice => firstOrNull?.wholesale_price ?? 0;

  int get getWholesaleNumber => firstOrNull?.wholesale_number ?? 0;

  String get getSku => firstOrNull?.sku ?? '';

  set setSku(String sku) => firstOrNull?.sku = sku.isEmpty ? null : sku;

  String get getUpc => firstOrNull?.upc ?? '';

  set setUPC(String upc) => firstOrNull?.upc = upc.isEmpty ? null : upc;

  int get getInventory => firstOrNull?.inventory_number ?? 0;

  set setInventory(int number) => firstOrNull?.inventory_number = number;

  bool get isEnableWarehouse => firstOrNull?.enable_warehouse ?? false;

  String? get getUnitFristLargeImg {
    final firstUnitID = firstOrNull?.beerUnitSecondId;
    if (firstUnitID == null) {
      return null;
    }
    for (var img in images) {
      if (img.tag != null && img.tag == firstUnitID) {
        return img.medium;
      }
    }
    return null;
  }

  String get getRangePrice {
    if (listUnit == null || listUnit!.isEmpty) {
      return '0';
    }
    double min = 0;
    double max = 0;
    for (final element in listUnit!) {
      if (element.isHide || !element.isAvariable) {
        continue;
      }
      final currentPrice = element.realPrice;
      if (min == 0) {
        min = currentPrice;
      }
      if (max == 0) {
        max = currentPrice;
      }
      if (currentPrice > max) {
        max = currentPrice;
      }
      if (currentPrice < min) {
        min = currentPrice;
      }
    }
    if (min == max) {
      return MoneyFormater.format(min);
    }
    return '${MoneyFormater.format(min)} - ${MoneyFormater.format(max)}';
  }

  void setWholesalePrice(double price) {
    firstOrNull?.wholesale_price = price;
  }

  void setWholesaleNumber(int no) {
    firstOrNull?.wholesale_number = no;
  }

  bool isContainCategory(List<String> listCat) {
    for (String cat in listCat) {
      if (category.contains(cat)) return true;
    }
    return false;
  }

  bool isContainUnitCategory(List<String> listCat) {
    final unit = firstOrNull;
    if (unit == null) {
      return false;
    }
    for (String cat in listCat) {
      if (unit.name.contains(cat)) return true;
    }
    return false;
  }

  bool searchMatch(String srx) {
    if (meta_search?.contains(srx) == true) {
      return true;
    }
    return false;
  }

  void addImg(Images img) {
    images.add(img);
  }

  void replaceImg(Images oldImg, Images newImg) {
    int replaceIndex = images.indexOf(oldImg);
    if (replaceIndex >= 0) {
      print('Replace with index: $replaceIndex');
      images[replaceIndex] = newImg;
    }
  }

  void deleteImg(Images img) {
    images.remove(img);
  }

  bool get isAvariable => status == 'AVARIABLE';

  void changeStatus(bool st) {
    if (st) {
      status = 'AVARIABLE';
      return;
    }
    status = 'SOLD_OUT';
  }

  void changeUnitStatus(BeerUnit? unit, bool st) {
    unit?.changeAvariable(st);
  }

  void switcEnableWareHouse(bool isEnable) {
    firstOrNull?.enable_warehouse = isEnable;
  }
}

@HiveType(typeId: 4)
class Images {
  Images({
    required this.groupId,
    required this.createat,
    required this.id,
    required this.imgid,
    this.tag,
    required this.thumbnail,
    required this.medium,
    required this.large,
    required this.category,
  });
  @HiveField(0)
  late final String groupId;

  @HiveField(1)
  late final String createat;

  @HiveField(2)
  late final int id;

  @HiveField(3)
  late final String imgid;

  @HiveField(4)
  late final String? tag;

  @HiveField(5)
  late final String thumbnail;

  @HiveField(6)
  late final String medium;

  @HiveField(7)
  late final String large;

  @HiveField(8)
  late final String category;

  Uint8List? content;
  bool? upload;

  Images.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    createat = json['createat'];
    id = json['id'];
    imgid = json['imgid'];
    tag = null;
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['createat'] = createat;
    _data['id'] = id;
    _data['imgid'] = imgid;
    _data['tag'] = tag;
    _data['thumbnail'] = thumbnail;
    _data['medium'] = medium;
    _data['large'] = large;
    _data['category'] = category;
    return _data;
  }

  factory Images.createEmpty(BeerSubmitData product) {
    return Images(
        groupId: product.groupId,
        createat: '',
        id: 0,
        imgid: '',
        thumbnail: '',
        medium: '',
        large: '',
        category: product.beerSecondID);
  }
}

@HiveType(typeId: 5)
class BeerUnit {
  BeerUnit({
    required this.groupId,
    required this.beer,
    required this.name,
    required this.price,
    required this.buyPrice,
    required this.discount,
    this.dateExpir,
    required this.volumetric,
    required this.weight,
    required this.beerUnitSecondId,
    required this.status,
    required this.wholesale_price,
    required this.wholesale_number,
    required this.sku,
    required this.upc,
    required this.promotional_price,
    required this.inventory_number,
    required this.visible,
    required this.enable_warehouse,
  }) {
    correctPrice();
    correctStatus();
  }
  @HiveField(0)
  late final String groupId;

  @HiveField(1)
  late final String beer;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late double price;

  @HiveField(4)
  late double buyPrice;

  @HiveField(5)
  late final double discount;

  @HiveField(6)
  late final DateExpir? dateExpir;

  @HiveField(7)
  late final double volumetric;

  @HiveField(8)
  late final double? weight;

  @HiveField(9)
  late final String beerUnitSecondId;

  @HiveField(10)
  late String status;

  @HiveField(11)
  late double? wholesale_price;

  @HiveField(12)
  late int? wholesale_number;

  @HiveField(13)
  late String? sku;

  @HiveField(14)
  late String? upc;

  @HiveField(15)
  late double? promotional_price;

  @HiveField(16)
  late int? inventory_number;

  @HiveField(17)
  late bool? visible;

  @HiveField(18)
  late bool? enable_warehouse;

  factory BeerUnit.empty(
      String groupID, String productID, String name, String? productUnitid) {
    final productUnitID = productUnitid ?? generateUUID();
    return BeerUnit(
      groupId: groupID,
      beer: productID,
      beerUnitSecondId: productUnitID,
      name: name,
      price: 0,
      buyPrice: 0,
      discount: 0,
      volumetric: 0,
      weight: 0,
      status: '',
      wholesale_price: 0,
      wholesale_number: 0,
      sku: null,
      upc: null,
      promotional_price: 0,
      inventory_number: 0,
      visible: true,
      enable_warehouse: false,
    );
  }

  BeerUnit.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    beer = json['beer'];
    name = json['name'];
    price = json['price'];
    buyPrice = json['buy_price'];
    discount = json['discount'];
    dateExpir = json['dateExpir'] == null
        ? null
        : DateExpir.fromJson(json['dateExpir']);
    volumetric = json['volumetric'];
    weight = json['weight'];
    beerUnitSecondId = json['beer_unit_second_id'];
    status = json['status'];
    wholesale_price = json['wholesale_price'] as double;
    wholesale_number = json['wholesale_number'] as int;
    sku = json['sku'];
    upc = json['upc'];
    promotional_price = json['promotional_price'] as double;
    inventory_number = json['inventory_number'] as int;
    visible = json['visible'] == null ? true : json['visible'] as bool;
    enable_warehouse = json['enable_warehouse'] == null
        ? false
        : json['enable_warehouse'] as bool;

    correctPrice();
    correctStatus();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['beer'] = beer;
    _data['name'] = name;
    _data['price'] = price;
    _data['buy_price'] = buyPrice;
    _data['discount'] = discount;
    _data['dateExpir'] = dateExpir?.toJson();
    _data['volumetric'] = volumetric;
    _data['weight'] = weight;
    _data['beer_unit_second_id'] = beerUnitSecondId;
    _data['status'] = status;
    _data['wholesale_price'] = wholesale_price;
    _data['wholesale_number'] = wholesale_number;
    _data['sku'] = sku;
    _data['upc'] = upc;
    _data['promotional_price'] = promotional_price;
    _data['inventory_number'] = inventory_number;
    _data['visible'] = visible;
    _data['enable_warehouse'] = enable_warehouse;
    return _data;
  }

  double get realPrice {
    if (promotional_price == null || promotional_price == 0) {
      return _realPrice;
    }
    return promotional_price!;
  }

  double _realPrice = 0;

  void correctPrice() {
    _realPrice = price * (1 - discount / 100);
  }

  BeerUnit updatename(String name) {
    this.name = name;
    return this;
  }

  void correctStatus() {
    unitStatus = ProductUnitStatus.values.byNameOrNull(status) ??
        ProductUnitStatus.AVARIABLE;
  }

  void changeTohide(bool isHide) {
    visible = !isHide;
  }

  void changeAvariable(bool isAvariable) {
    unitStatus =
        isAvariable ? ProductUnitStatus.AVARIABLE : ProductUnitStatus.SOLD_OUT;
    status = unitStatus.name;
  }

  void copyConfig(BeerUnit beerUnit) {
    price = beerUnit.price;
    buyPrice = beerUnit.buyPrice;
    inventory_number = beerUnit.inventory_number;
  }

  bool get isHide => visible == false;

  bool get isAvariable => unitStatus == ProductUnitStatus.AVARIABLE;

  late ProductUnitStatus unitStatus;
}

@HiveType(typeId: 6)
class DateExpir {
  DateExpir({
    required this.day,
    required this.month,
    required this.year,
  });
  @HiveField(0)
  late final int day;

  @HiveField(1)
  late final int month;

  @HiveField(2)
  late final int year;

  DateExpir.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['month'] = month;
    _data['year'] = year;
    return _data;
  }
}

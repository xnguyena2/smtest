import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/result_interface.dart';

part 'beer_submit_data.g.dart';

@HiveType(typeId: 2)
class BeerSubmitData extends BaseEntity implements ResultInterface {
  BeerSubmitData({
    super.id,
    required super.groupId,
    super.createat,
    required this.beerSecondID,
    required this.name,
    this.detail,
    this.sku,
    this.upc,
    required this.category,
    required this.status,
    this.meta_search,
    this.images,
    required this.listUnit,
    required this.list_categorys,
  });

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
  late List<Images>? images;

  @HiveField(11)
  late final List<BeerUnit>? listUnit;

  @HiveField(12)
  late List<String>? list_categorys;

  @HiveField(13)
  late final String? sku;

  @HiveField(14)
  late final String? upc;

  BeerSubmitData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    beerSecondID = json['beerSecondID'];
    name = json['name'];
    detail = json['detail'];
    sku = json['sku'];
    upc = json['upc'];
    category = json['category'];
    meta_search = json['meta_search'];
    status = json['status'];
    images = json['images'] == null
        ? null
        : List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    listUnit =
        List.from(json['listUnit']).map((e) => BeerUnit.fromJson(e)).toList();

    list_categorys = toListCat(category);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['group_id'] = groupId;
    _data['beerSecondID'] = beerSecondID;
    _data['name'] = name;
    _data['detail'] = detail;
    _data['sku'] = sku;
    _data['upc'] = upc;
    _data['category'] = category;
    _data['meta_search'] = meta_search;
    _data['status'] = status;
    _data['images'] = images?.map((e) => e.toJson()).toList();
    _data['listUnit'] = listUnit?.map((e) => e.toJson()).toList();
    return _data;
  }

  BeerSubmitData cloneMainData(BeerUnit? unit) {
    return BeerSubmitData(
      groupId: groupId,
      beerSecondID: beerSecondID,
      name: '$name(${unit?.name ?? 'Removed'})',
      category: category,
      status: status,
      detail: detail,
      images: images,
      listUnit: unit != null ? [unit] : null,
      meta_search: meta_search,
      list_categorys: list_categorys,
      sku: sku,
      upc: upc,
    );
  }

  factory BeerSubmitData.createEmpty(String groupID, String productID) {
    return BeerSubmitData(
      groupId: groupID,
      beerSecondID: productID,
      name: '',
      category: '',
      status: '',
      listUnit: [
        BeerUnit(
            groupId: groupID,
            beer: productID,
            name: '',
            price: 0,
            buyPrice: 0,
            discount: 0,
            volumetric: 0,
            weight: 0,
            beerUnitSecondId: '',
            status: '')
      ],
      list_categorys: [],
    );
  }

  List<String> toListCat(String? cats) {
    if (cats == null) return [];
    return cats.split('<<CAT>>');
  }

  String toListCatTxt(List<String> cats) {
    return cats.join('<<CAT>>');
  }

  void updateListCat(List<String> cats) {
    list_categorys = cats;
    category = toListCatTxt(cats);
  }

  List<BeerSubmitData> flatUnit() {
    return listUnit == null
        ? [this]
        : listUnit!.map((e) => cloneMainData(e)).toList();
  }

  String? get getFristLargeImg => images?[0].medium;

  double get getRealPrice => listUnit?[0].realPrice ?? 0;

  double get getBuyPrice => listUnit?[0].buyPrice ?? 0;

  double get getPrice => listUnit?[0].price ?? 0;

  bool isContainCategory(List<String> listCat) {
    for (String cat in listCat) {
      if (category.contains(cat)) return true;
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
    if (images == null) {
      images = [];
    }
    images?.add(img);
  }

  void replaceImg(Images oldImg, Images newImg) {
    int replaceIndex = images?.indexOf(oldImg) ?? -1;
    if (replaceIndex >= 0) {
      print('Replace with index: $replaceIndex');
      images?[replaceIndex] = newImg;
    }
  }

  void deleteImg(Images img) {
    images?.remove(img);
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
  });
  @HiveField(0)
  late final String groupId;

  @HiveField(1)
  late final String beer;

  @HiveField(2)
  late final String name;

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
  late final String status;

  late double realPrice = 0;

  void correctPrice() {
    realPrice = price * (1 - discount / 100);
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

    correctPrice();
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
    return _data;
  }
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

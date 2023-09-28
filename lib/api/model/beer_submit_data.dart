import 'package:sales_management/api/model/result_interface.dart';

class BeerSubmitData extends ResultInterface {
  BeerSubmitData({
    required this.groupId,
    required this.beerSecondID,
    required this.name,
    this.detail,
    required this.category,
    required this.status,
    this.images,
    required this.listUnit,
  });
  late final String groupId;
  late final String beerSecondID;
  late final String name;
  late final String? detail;
  late final String category;
  late final String status;
  late final List<Images>? images;
  late final List<BeerUnit>? listUnit;

  BeerSubmitData.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    beerSecondID = json['beerSecondID'];
    name = json['name'];
    detail = json['name'];
    category = json['category'];
    status = json['status'];
    images = json['images'] == null
        ? null
        : List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    listUnit =
        List.from(json['listUnit']).map((e) => BeerUnit.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['beerSecondID'] = beerSecondID;
    _data['name'] = name;
    _data['detail'] = detail;
    _data['category'] = category;
    _data['status'] = status;
    _data['images'] = images;
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
    );
  }

  List<BeerSubmitData> flatUnit() {
    return listUnit == null
        ? [this]
        : listUnit!.map((e) => cloneMainData(e.correctPrice())).toList();
  }

  String? get getFristLargeImg => images?[0].medium;

  double get getRealPrice => listUnit?[0].realPrice ?? 0;
}

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
  late final String groupId;
  late final String createat;
  late final String id;
  late final String imgid;
  late final Null tag;
  late final String thumbnail;
  late final String medium;
  late final String large;
  late final String category;

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
}

class BeerUnit {
  BeerUnit({
    required this.groupId,
    required this.beer,
    required this.name,
    required this.price,
    required this.discount,
    this.dateExpir,
    required this.volumetric,
    required this.weight,
    required this.beerUnitSecondId,
    required this.status,
  });
  late final String groupId;
  late final String beer;
  late final String name;
  late final double price;
  late final double discount;
  late final DateExpir? dateExpir;
  late final double volumetric;
  late final double? weight;
  late final String beerUnitSecondId;
  late final String status;

  double realPrice = 0;

  BeerUnit correctPrice() {
    realPrice = price * (1 - discount / 100);
    return this;
  }

  BeerUnit.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    beer = json['beer'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    dateExpir = null;
    volumetric = json['volumetric'];
    weight = json['weight'];
    beerUnitSecondId = json['beer_unit_second_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['beer'] = beer;
    _data['name'] = name;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['dateExpir'] = dateExpir;
    _data['volumetric'] = volumetric;
    _data['weight'] = weight;
    _data['beer_unit_second_id'] = beerUnitSecondId;
    _data['status'] = status;
    return _data;
  }
}

class DateExpir {
  DateExpir({
    required this.day,
    required this.month,
    required this.year,
  });
  late final int day;
  late final int month;
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

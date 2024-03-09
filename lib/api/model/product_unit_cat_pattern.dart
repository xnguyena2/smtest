import 'dart:convert';

import 'package:sales_management/utils/utils.dart';

class ProductUnitCatPattern {
  late final List<ProductUnitCatPatternItem> items;
  late Map<String, ProductUnitIDWithName> productUnitKeyTree;

  ProductUnitCatPattern({
    required this.items,
    required this.productUnitKeyTree,
  });

  factory ProductUnitCatPattern.fromJsonString(String? json) {
    if (json == null || json.isEmpty) {
      return ProductUnitCatPattern(items: [], productUnitKeyTree: {});
    }
    return ProductUnitCatPattern.fromJson(jsonDecode(json));
  }

  ProductUnitCatPattern.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];
    items = itemsJson == null
        ? []
        : List.from(itemsJson)
            .map((e) => ProductUnitCatPatternItem.fromJson(e))
            .toList();
    final productJson = json['productUnitKeyTree'];

    productUnitKeyTree = productJson == null
        ? {}
        : Map.from(productJson).map((key, value) =>
            MapEntry(key, ProductUnitIDWithName.fromJson(value)));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['productUnitKeyTree'] =
        productUnitKeyTree.map((key, value) => MapEntry(key, value.toJson()));
    return _data;
  }

  ProductUnitCatPattern clone() {
    return ProductUnitCatPattern.fromJson(toJson());
  }

  String toJsonString() {
    return jsonEncode(this);
  }

  void addnewEmptyItem() {
    items.add(ProductUnitCatPatternItem.empty());
  }

  void addItem(ProductUnitCatPatternItem newI) {
    items.add(newI);
  }

  void delteItem(ProductUnitCatPatternItem item) {
    items.remove(item);
  }

  List<ProductUnitIDWithName> rebuildTree() {
    if (items.isEmpty) {
      productUnitKeyTree.clear();
      return [];
    }
    final newTree = <String, ProductUnitIDWithName>{};
    final first = items[0];
    first.items.forEach(
      (key, value) {
        appendTree(MapEntry(key, value), 1, newTree);
      },
    );
    productUnitKeyTree.clear();
    productUnitKeyTree = newTree;
    return productUnitKeyTree.values.toList();
  }

  void appendTree(MapEntry<String, String> prefix, int index,
      Map<String, ProductUnitIDWithName> newTree) {
    if (index >= items.length || items[index].items.isEmpty) {
      final mainKey = prefix.key;
      final oldValue = productUnitKeyTree[mainKey];
      final unitID = oldValue?.id ?? generateUUID();
      newTree[mainKey] = ProductUnitIDWithName(id: unitID, name: prefix.value);
      return;
    }
    final item = items[index];
    item.items.forEach((key, value) {
      final mainKey = '${prefix.key}<->${key}';
      final mainValue = '${prefix.value} - ${value}';
      appendTree(MapEntry(mainKey, mainValue), index + 1, newTree);
    });
  }

  int get getTotalCateNum {
    int total = 0;
    items.forEach((element) {
      total += element.items.length;
    });
    return total;
  }
}

class ProductUnitCatPatternItem {
  late String name;

  late final Map<String, String> items;

  ProductUnitCatPatternItem({
    required this.name,
    required this.items,
  });

  ProductUnitCatPatternItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    final jsonV = json['items'];
    items = jsonV == null ? {} : Map.from(jsonV);
  }

  ProductUnitCatPatternItem.empty() {
    name = '';
    items = {};
  }

  ProductUnitCatPatternItem.categorySample() {
    name = 'Kích thước';
    items = {
      generateUUID(): 'Nhỏ (S)',
      generateUUID(): 'Vừa (M)',
      generateUUID(): 'Lớn (L)',
    };
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['items'] = items;
    return _data;
  }

  void removeItemByKey(String key) {
    items.remove(key);
  }

  void update(String key, String name) {
    items[key] = name;
  }

  void addItem(String item) {
    if (items.values.contains(item)) {
      return;
    }
    items[generateUUID()] = item;
  }
}

class ProductUnitIDWithName {
  late String id;
  late String name;

  ProductUnitIDWithName({
    required this.id,
    required this.name,
  });

  ProductUnitIDWithName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

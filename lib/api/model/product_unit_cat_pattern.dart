import 'dart:convert';

class ProductUnitCatPattern {
  late final List<ProductUnitCatPatternItem> items;

  ProductUnitCatPattern({
    required this.items,
  });

  ProductUnitCatPattern.fromJsonString(String? json) {
    if (json == null || json.isEmpty) {
      items = [];
      return;
    }
    items = ProductUnitCatPattern.fromJson(jsonDecode(json)).items;
  }

  ProductUnitCatPattern.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];
    items = itemsJson == null
        ? []
        : List.from(itemsJson)
            .map((e) => ProductUnitCatPatternItem.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e) => e.toJson()).toList();
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
}

class ProductUnitCatPatternItem {
  late String id;

  late final List<String> items;

  ProductUnitCatPatternItem({
    required this.id,
    required this.items,
  });

  ProductUnitCatPatternItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    items = List.from(json['items']);
  }

  ProductUnitCatPatternItem.empty() {
    id = '';
    items = [];
  }

  ProductUnitCatPatternItem.categorySample() {
    id = 'Kích thước';
    items = [
      'Nhỏ (S)',
      'Vừa (M)',
      'Lớn (L)',
    ];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['items'] = items;
    return _data;
  }

  void removeItem(String item) {
    items.remove(item);
  }

  void removeItemAt(int index) {
    items.removeAt(index);
  }

  void updateAt(int index, String name) {
    items[index] = name;
  }

  void addItem(String item) {
    if (items.contains(item)) {
      return;
    }
    items.add(item);
  }
}

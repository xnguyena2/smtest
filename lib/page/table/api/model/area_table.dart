import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/utils/utils.dart';

class ListAreDataResult {
  ListAreDataResult({
    required this.listResult,
  });
  late final List<AreaData> listResult;
  ListAreDataResult.fromJson(Map<String, dynamic> json) {
    listResult = List.from(json['list_result'])
        .map((e) => AreaData.fromJson(e))
        .toList();
  }

  (int, int) get getStatus {
    int available = 0;
    int inUse = 0;
    listResult.forEach((element) {
      var (u, a) = element.getStatus;
      inUse += u;
      available += a;
    });
    return (inUse, available);
  }

  List<String> get getListAreName => listResult
      .map(
        (e) => e.areaName ?? 'unknow',
      )
      .toList();
}

class AreaData extends BaseEntity {
  AreaData({
    required int id,
    required String groupId,
    required String createat,
    required this.areaId,
    this.areaName,
    this.detail,
    this.metaSearch,
    this.status,
    required this.listTable,
  }) : super(id: id, groupId: groupId, createat: createat);

  late final String areaId;
  late final String? areaName;
  late final String? detail;
  late final String? metaSearch;
  late final String? status;
  late final List<TableDetailData>? listTable;

  AreaData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
    detail = json['detail'];
    metaSearch = json['meta_search'];
    status = json['status'];
    listTable = List.from(json['listTable'])
        .map((e) => TableDetailData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['area_id'] = areaId;
    _data['area_name'] = areaName;
    _data['detail'] = detail;
    _data['meta_search'] = metaSearch;
    _data['status'] = status;
    _data['listTable'] = listTable?.map((e) => e.toJson()).toList();
    return _data;
  }

  (int, int) get getStatus {
    int total = 0;
    int inUse = 0;
    listTable?.forEach((element) {
      total++;
      if (element.isUsed) {
        inUse++;
      }
    });
    return (inUse, total - inUse);
  }
}

class TableDetailData extends BaseEntity {
  TableDetailData({
    required int id,
    required String groupId,
    required String createat,
    required this.areaId,
    required this.tableId,
    this.packageSecondId,
    required this.tableName,
    this.detail,
    this.status,
    required this.price,
  }) : super(id: id, groupId: groupId, createat: createat);
  late final String areaId;
  late final String tableId;
  late String? packageSecondId;
  late final String? tableName;
  late String? detail;
  late final String? status;
  late final double price;

  late final DateTime? startUsed;

  TableDetailData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    areaId = json['area_id'];
    tableId = json['table_id'];
    packageSecondId = json['package_second_id'];
    tableName = json['table_name'];
    detail = json['detail'];
    status = json['status'];
    price = json['price'] as double;
    startUsed = createat != null ? stringToDateTime(createat!).toLocal() : null;
    print('db time: ${createat}, local time: ${startUsed.toString()}');
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['area_id'] = areaId;
    _data['table_id'] = tableId;
    _data['package_second_id'] = packageSecondId;
    _data['table_name'] = tableName;
    _data['detail'] = detail;
    _data['status'] = status;
    _data['price'] = price;
    return _data;
  }

  bool get isUsed => packageSecondId != null && price >= 0;

  Duration get calcTimeUsed =>
      startUsed == null ? Duration.zero : DateTime.now().difference(startUsed!);

  String get timeElapsed {
    Duration timeElasped = calcTimeUsed;
    if (timeElasped.inDays > 0) {
      return '${timeElasped.inDays} ngày';
    }
    if (timeElasped.inHours > 0) {
      return '${timeElasped.inHours} giờ';
    }
    if (timeElasped.inMinutes > 0) {
      return '${timeElasped.inMinutes} phút';
    }
    return '${timeElasped.inSeconds} giây';
  }
}

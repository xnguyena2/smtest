import 'package:sales_management/api/model/base_id.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/utils/constants.dart';

class PackageID extends BaseID {
  late final String? packageSecondId;
  late final String? deviceId;
  late final String? from;
  late final String? to;
  late final String? status;

  PackageID({
    required super.group_id,
    required super.page,
    required super.size,
    required this.packageSecondId,
    required this.deviceId,
    required this.from,
    required this.to,
    required this.status,
  });

  PackageID.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    deviceId = json['device_id'];
    packageSecondId = json['package_id'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
  }

  PackageID.fromPackageID(String id,
      {this.from, this.to, this.status, int page = 0, int size = 10000})
      : super(group_id: groupID, page: page, size: size) {
    deviceId = null;
    packageSecondId = id;
  }

  PackageID.fromPackageDataResponse(PackageDataResponse packageDataResponse,
      {this.from, this.to, this.status, int page = 0, int size = 10000})
      : super(group_id: packageDataResponse.groupId, page: page, size: size) {
    deviceId = packageDataResponse.deviceId;
    packageSecondId = packageDataResponse.packageSecondId;
  }

  PackageID.currentMonth(String groupID,
      {this.from, this.to, this.status, int page = 0, int size = 10000})
      : super(group_id: groupID, page: page, size: size) {
    deviceId = '';
    packageSecondId = '';
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['device_id'] = deviceId;
    _data['package_id'] = packageSecondId;
    _data['from'] = from;
    _data['to'] = to;
    _data['status'] = status;
    return _data;
  }
}

import 'dart:convert';

import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/address/api/model/region.dart';
import 'package:sales_management/utils/constants.dart';

Future<RegionResult> fetchRegion() async {
  final response = await getE('/address/allregionformat/');

  if (response.statusCode == 200) {
    // print(response.body);
    return RegionResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}

Future<RegionResult> fetchDistrict(Region region) async {
  final response = await getE('/address/districtformat/${region.id}');

  if (response.statusCode == 200) {
    // print(response.body);
    return RegionResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}

Future<RegionResult> fetchWard(Region region, Region district) async {
  final response =
      await getE('/address/wardformat/${region.id}/${district.id}');

  if (response.statusCode == 200) {
    // print(response.body);
    return RegionResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}
import 'dart:convert';

import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/user_info_query.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';

Future<ListAreDataResult> getAllTable(String groupID) async {
  final request = UserInfoQuery(
    page: 0,
    size: 1000,
    id: '',
    group_id: groupID,
  );

  final response = await postE(
    '/table/getall',
    request,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return ListAreDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> setPackageId(TableDetailData tableDetailData) async {
  final request = tableDetailData;

  final response = await postE(
    '/table/setpackage',
    request,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<TableDetailData> createTable(TableDetailData tableDetailData) async {
  final request = tableDetailData;

  // print(json.encode(tableDetailData));
  final response = await postE(
    '/table/savetable',
    request,
  );

  if (response.statusCode == 200) {
    print(response.body);
    return TableDetailData.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<AreaData> createListTable(AreaData areaData) async {
  final request = areaData;

  // print(json.encode(areaData));

  final response = await postE(
    '/table/createlisttable',
    request,
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    return AreaData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<AreaData> updateAreaData(AreaData areaData) async {
  final request = areaData;

  // print(json.encode(tableDetailData));
  final response = await postE(
    '/table/savearea',
    request,
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    return AreaData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<AreaData> deleteAreaData(AreaData areaData) async {
  final request = areaData;

  // print(json.encode(tableDetailData));
  final response = await postE(
    '/table/deletearea',
    request,
  );

  if (response.statusCode == 200) {
    print(response.body);
    return AreaData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<TableDetailData> deleteTable(TableDetailData tableDetailData) async {
  final request = tableDetailData;

  // print(json.encode(tableDetailData));
  final response = await postE(
    '/table/deletetable',
    request,
  );

  if (response.statusCode == 200) {
    print(response.body);
    return TableDetailData.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

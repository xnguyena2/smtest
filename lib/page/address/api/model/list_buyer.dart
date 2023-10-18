import 'package:sales_management/api/model/package/package_data_response.dart';

class ListBuyerResult {
  ListBuyerResult({
    required this.listResult,
  });
  late final List<BuyerData> listResult;
  ListBuyerResult.fromJson(Map<String, dynamic> json) {
    listResult = List.from(json['list_result'])
        .map((e) => BuyerData.fromJson(e))
        .toList();
  }
}

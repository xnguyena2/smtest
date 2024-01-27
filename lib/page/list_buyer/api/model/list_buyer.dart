import 'package:sales_management/api/model/package/package_data_response.dart';

class ListBuyerDataResult {
  ListBuyerDataResult({
    required this.listResult,
  });
  late final List<BuyerData> listResult;
  ListBuyerDataResult.fromJson(Map<String, dynamic> json) {
    listResult = json['list_result'] == null
        ? []
        : List.from(json['list_result'])
            .map((e) => BuyerData.fromJson(e))
            .toList();
  }
}

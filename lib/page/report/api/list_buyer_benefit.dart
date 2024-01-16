import 'package:sales_management/page/home/api/model/benifit_by_buyer_of_month.dart';

class ListBuyerBenifitDataResult {
  ListBuyerBenifitDataResult({
    required this.listResult,
  });
  late final List<BenifitByBuyerOfMonth> listResult;
  ListBuyerBenifitDataResult.fromJson(Map<String, dynamic> json) {
    listResult = json['list_result'] == null
        ? []
        : List.from(json['list_result'])
            .map((e) => BenifitByBuyerOfMonth.fromJson(e))
            .toList();
  }
}

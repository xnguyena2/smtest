import 'package:sales_management/page/home/api/model/benifit_by_order_of_month.dart';

class ListOrderBenifitDataResult {
  ListOrderBenifitDataResult({
    required this.listResult,
  });
  late final List<BenifitByOrderOfMonth> listResult;
  ListOrderBenifitDataResult.fromJson(Map<String, dynamic> json) {
    listResult = json['list_result'] == null
        ? []
        : List.from(json['list_result'])
            .map((e) => BenifitByOrderOfMonth.fromJson(e))
            .toList();
    listResult.sort(
      (a, b) => b.createat.compareTo(a.createat),
    );
  }
}

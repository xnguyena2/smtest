import 'package:sales_management/page/home/api/model/benifit_by_product_of_month.dart';

class ListProductBenifitDataResult {
  ListProductBenifitDataResult({
    required this.listResult,
  });
  late final List<BenifitByProductOfMonth> listResult;
  ListProductBenifitDataResult.fromJson(Map<String, dynamic> json) {
    listResult = json['list_result'] == null
        ? []
        : List.from(json['list_result'])
            .map((e) => BenifitByProductOfMonth.fromJson(e))
            .toList();
  }
}

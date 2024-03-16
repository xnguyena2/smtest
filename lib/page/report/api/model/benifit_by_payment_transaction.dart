import 'package:sales_management/component/interface/item_report_category_item_interface.dart';
import 'package:sales_management/utils/utils.dart';

class BenifitByPaymentTransaction implements ItemReportCategoryItemInterface {
  BenifitByPaymentTransaction({
    required this.category,
    required this.revenue,
    required this.cost,
  });

  late final String? category;
  late final double revenue;
  late final double cost;

  BenifitByPaymentTransaction.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    revenue = castToDouble(json['revenue']);
    cost = castToDouble(json['cost']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category'] = category;
    _data['revenue'] = revenue;
    _data['cost'] = cost;
    return _data;
  }
}

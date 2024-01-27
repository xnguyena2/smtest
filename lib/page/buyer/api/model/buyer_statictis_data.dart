import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/home/api/model/benifit_by_product_of_month.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';

class BuyerStatictisData {
  BuyerStatictisData({
    required this.buyer,
    required this.benifitByProducts,
    required this.benifitByMonth,
    required this.packageDataResponses,
  });

  late final Buyer? buyer;
  late final List<BenifitByProduct> benifitByProducts;
  late final BenifitByMonth benifitByMonth;
  late final List<PackageDataResponse> packageDataResponses;

  BuyerStatictisData.fromJson(Map<String, dynamic> json) {
    buyer = json['buyer'] == null ? null : Buyer.fromJson(json['buyer']);

    final benifitByProductsJs = json['benifitByProducts'];
    benifitByProducts = benifitByProductsJs == null
        ? []
        : List.from(benifitByProductsJs)
            .map((e) => BenifitByProduct.fromJson(e))
            .toList();

    benifitByMonth = BenifitByMonth.fromJson(json['benifitByMonth']);

    final packageDataResponsesJs = json['packageDataResponses'];
    packageDataResponses = packageDataResponsesJs == null
        ? []
        : List.from(packageDataResponsesJs)
            .map((e) => PackageDataResponse.fromJson(e))
            .toList();
    packageDataResponses.sort(
      (a, b) => b.createat?.compareTo(a.createat ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['buyer'] = buyer;
    _data['benifitByProducts'] = benifitByProducts;
    _data['benifitByMonth'] = benifitByMonth;
    _data['packageDataResponses'] = packageDataResponses;
    return _data;
  }

  String? getLastestTimeOrder() {
    if (packageDataResponses.isEmpty) {
      return null;
    }
    return packageDataResponses[0].createat;
  }
}

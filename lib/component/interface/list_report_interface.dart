import 'package:sales_management/component/interface/report_with_offset_interface.dart';

abstract interface class ListReportInterface {
  List<ReportWithOffset> getListResultFlat();

  String getTimeStampFrom({required int offset});
  int get first;
  int get last;

  double get totalSellingRevenue;
  double get totalSellingCost;

  double get totalIncome;
  double get totalOutCome;

  double get totalPrice;
  double get totalRevenue;
  double get totalCost;
  double get totalProfit;
  double get totalShipPrice;
  double get totalDiscount;
  double totalDiscountPromotional = 0;
  double totalDiscountByPoint = 0;
  double totalReturnPrice = 0;
  double totalAdditionalFee = 0;
  int get numberBuyer;
  int get numOrder;
}

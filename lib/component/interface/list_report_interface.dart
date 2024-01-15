import 'package:sales_management/component/interface/report_interface.dart';
import 'package:sales_management/component/interface/report_with_offset_interface.dart';

abstract interface class ListReportInterface {
  List<ReportInterface> getListResult();
  List<ReportWithOffset> getListResultFlat();

  String getTimeStampFrom({required int offset});
  int get first;
  int get last;

  double get totalPrice;
  double get totalRevenue;
  double get totalCost;
  double get totalProfit;
  double get totalShipPrice;
  double get totalDiscount;
  int get numberBuyer;
  int get numOrder;
}

import 'package:sales_management/component/interface/list_report_interface.dart';
import 'package:sales_management/component/interface/report_with_offset_interface.dart';
import 'package:sales_management/page/home/api/model/benifit_by_date_of_month.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/model/benifit_by_payment_transaction.dart';
import 'package:sales_management/utils/utils.dart';

class BenifitOfOrderAndPaymentTransactionByDate implements ListReportInterface {
  BenifitOfOrderAndPaymentTransactionByDate({
    required this.benifit_by_date,
    required this.benifit_by_date_transaction,
    required this.benifit_by_category_transaction,
    required this.return_price,
  });
  late final List<BenifitByDate> benifit_by_date;
  late final List<BenifitByDate> benifit_by_date_transaction;

  late final List<BenifitByPaymentTransaction> benifit_by_category_transaction;

  late double return_price;

  BenifitOfOrderAndPaymentTransactionByDate.fromJson(
      Map<String, dynamic> json) {
    benifit_by_date = json['benifit_by_date'] == null
        ? []
        : List.from(json['benifit_by_date'])
            .map((e) => BenifitByDate.fromJson(e))
            .toList();

    benifit_by_date_transaction = json['benifit_by_date_transaction'] == null
        ? []
        : List.from(json['benifit_by_date_transaction'])
            .map((e) => BenifitByDate.fromJson(e))
            .toList();

    benifit_by_category_transaction =
        json['benifit_by_category_transaction'] == null
            ? []
            : List.from(json['benifit_by_category_transaction'])
                .map((e) => BenifitByPaymentTransaction.fromJson(e))
                .toList();

    return_price = castToDouble(json['return_price']);
  }

  late final List<BenifitByDateOfMonthWithOffset> listResultFlat;

  int first = 0;
  int last = 0;

  double totalSellingRevenue = 0;
  double totalSellingCost = 0;

  double totalIncome = 0;
  double totalOutCome = 0;

  double totalPrice = 0;
  double totalRevenue = 0;
  double totalCost = 0;
  double totalProfit = 0;
  double totalShipPrice = 0;
  double totalDiscount = 0;
  double totalDiscountPromotional = 0;
  double totalDiscountByPoint = 0;
  double totalReturnPrice = 0;
  double totalAdditionalFee = 0;
  int numberBuyer = 0;
  int numOrder = 0;

  void fillAllEmpty(String from, String to, bool fillAll) {
    first = extractTimeStamp(from);
    last = extractTimeStamp(to);

    Map<int, BenifitByDateOfMonthWithOffset> resultMaped =
        <int, BenifitByDateOfMonthWithOffset>{};

    for (var element in benifit_by_date) {
      numOrder += element.count;
      numberBuyer += element.buyer;
      totalPrice += element.price;
      totalRevenue += element.revenue;
      totalCost += element.cost;
      totalProfit += element.profit;
      totalShipPrice += element.ship_price;
      totalDiscount += element.discount;
      totalDiscountPromotional += element.discount_promotional;
      totalDiscountByPoint += element.discount_by_point;
      totalReturnPrice += element.return_price;
      totalAdditionalFee += element.additional_fee;
      int ts = extractTimeStamp(element.localTime);
      resultMaped[ts] = BenifitByDateOfMonthWithOffset(0, ts, data: element);
    }

    for (var element in benifit_by_date_transaction) {
      totalIncome += element.revenue;
      totalOutCome += element.cost;
      totalProfit += element.revenue - element.cost;
      int ts = extractTimeStamp(element.localTime);
      final benifit = resultMaped[ts];
      if (benifit == null) {
        element.profit = element.revenue - element.cost;
        resultMaped[ts] = BenifitByDateOfMonthWithOffset(0, ts, data: element);
      } else {
        benifit.data.revenue += element.revenue;
        benifit.data.cost += element.cost;
        benifit.data.profit += element.revenue - element.cost;
      }
    }

    totalSellingRevenue = totalPrice + totalShipPrice + totalAdditionalFee;

    totalSellingCost = totalDiscount + totalCost;

    print(
        'totalSellingRevenue: $totalSellingRevenue, totalSellingCost: $totalSellingCost, calcProfit: ${totalSellingRevenue - totalSellingCost}, totalProfit: $totalProfit');

    int offset = 0;
    for (int i = first; i <= last; i += 86400000) {
      var p = resultMaped[i];
      if (p == null) {
        if (fillAll) {
          resultMaped[i] = BenifitByDateOfMonthWithOffset(
            offset,
            i,
            data: BenifitByDate(
              localTime: timeStampToServerFormat(i),
              revenue: 0,
              profit: 0,
              cost: 0,
              count: 0,
              buyer: 0,
              price: 0,
              ship_price: 0,
              discount: 0,
              discount_promotional: 0,
              discount_by_point: 0,
              return_price: 0,
              additional_fee: 0,
            ),
          );
        }
      } else {
        p.offset = offset;
      }
      offset++;
    }

    listResultFlat = resultMaped.values.toList();
    listResultFlat.sort(
      (a, b) => a.offset.compareTo(b.offset),
    );
  }

  String getTimeStampFrom({required int offset}) {
    final ts = first + offset * 86400000;
    return timeStampToFormat(ts);
  }

  @override
  List<ReportWithOffset> getListResultFlat() {
    // TODO: implement getListResultFlat
    return listResultFlat;
  }
}

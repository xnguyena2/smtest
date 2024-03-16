import 'package:sales_management/component/interface/item_report_category_item_interface.dart';
import 'package:sales_management/component/interface/list_report_interface.dart';
import 'package:sales_management/component/interface/report_with_offset_interface.dart';
import 'package:sales_management/page/home/api/model/benifit_by_hour_of_date.dart';
import 'package:sales_management/page/report/api/list_hour_benefit.dart';
import 'package:sales_management/page/report/api/model/benifit_by_payment_transaction.dart';
import 'package:sales_management/utils/utils.dart';

class BenifitOfOrderAndPaymentTransactionByHour implements ListReportInterface {
  BenifitOfOrderAndPaymentTransactionByHour({
    required this.benifit_by_hour,
    required this.benifit_by_hour_transaction,
    required this.benifit_by_category_transaction,
    required this.return_price,
  });
  late final List<BenifitByDateHour> benifit_by_hour;
  late final List<BenifitByDateHour> benifit_by_hour_transaction;

  late final List<BenifitByPaymentTransaction> benifit_by_category_transaction;

  late double return_price;

  BenifitOfOrderAndPaymentTransactionByHour.fromJson(
      Map<String, dynamic> json) {
    benifit_by_hour = json['benifit_by_hour'] == null
        ? []
        : List.from(json['benifit_by_hour'])
            .map((e) => BenifitByDateHour.fromJson(e))
            .toList();

    benifit_by_hour_transaction = json['benifit_by_hour_transaction'] == null
        ? []
        : List.from(json['benifit_by_hour_transaction'])
            .map((e) => BenifitByDateHour.fromJson(e))
            .toList();

    benifit_by_category_transaction =
        json['benifit_by_category_transaction'] == null
            ? []
            : List.from(json['benifit_by_category_transaction'])
                .map((e) => BenifitByPaymentTransaction.fromJson(e))
                .toList();

    return_price = castToDouble(json['return_price']);
  }

  late final List<BenifitByHourOfDateWithOffset> listResultFlat;

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
    first = extractHourTimeStamp(from);
    last = extractHourTimeStamp(to);

    Map<int, BenifitByHourOfDateWithOffset> resultMaped =
        <int, BenifitByHourOfDateWithOffset>{};

    for (var element in benifit_by_hour) {
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
      int ts = extractHourTimeStamp(element.localTime);
      resultMaped[ts] = BenifitByHourOfDateWithOffset(0, ts, data: element);
    }

    totalReturnPrice = return_price;

    totalSellingRevenue =
        totalPrice + totalShipPrice + totalAdditionalFee - totalDiscount;

    totalSellingCost = totalCost;

    print(
        'totalSellingRevenue: $totalSellingRevenue, totalSellingCost: $totalSellingCost, calcProfit: ${totalSellingRevenue - totalSellingCost}, totalProfit: $totalProfit');

    for (var element in benifit_by_hour_transaction) {
      totalIncome += element.revenue;
      totalOutCome += element.cost;
      totalProfit += element.revenue - element.cost;
      int ts = extractHourTimeStamp(element.localTime);
      final benifit = resultMaped[ts];
      if (benifit == null) {
        element.profit = element.revenue - element.cost;
        resultMaped[ts] = BenifitByHourOfDateWithOffset(0, ts, data: element);
      } else {
        benifit.data.revenue += element.revenue;
        benifit.data.cost += element.cost;
        benifit.data.profit += element.revenue - element.cost;
      }
    }
    int offset = 0;
    for (int i = first; i <= last; i += 3600000) {
      var p = resultMaped[i];
      if (p == null) {
        if (fillAll) {
          resultMaped[i] = BenifitByHourOfDateWithOffset(
            offset,
            i,
            data: BenifitByDateHour(
              localTime: timeHourStampToServerFormat(i),
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
    final ts = first + offset * 3600000;
    return timeStampToHourFormat(ts);
  }

  @override
  List<ReportWithOffset> getListResultFlat() {
    // TODO: implement getListResultFlat
    return listResultFlat;
  }

  @override
  List<ItemReportCategoryItemInterface> getListCategory() {
    return benifit_by_category_transaction;
  }
}

import 'package:sales_management/component/interface/item_report_category_item_interface.dart';
import 'package:sales_management/component/interface/list_report_interface.dart';
import 'package:sales_management/component/interface/report_interface.dart';
import 'package:sales_management/component/interface/report_with_offset_interface.dart';
import 'package:sales_management/page/home/api/model/benifit_by_hour_of_date.dart';
import 'package:sales_management/utils/utils.dart';

class ListHourBenifitDataResult implements ListReportInterface {
  ListHourBenifitDataResult({
    required this.listResult,
  });
  late final List<BenifitByDateHour> listResult;
  late final List<BenifitByHourOfDateWithOffset> listResultFlat;
  ListHourBenifitDataResult.fromJson(Map<String, dynamic> json) {
    listResult = json['list_result'] == null
        ? []
        : List.from(json['list_result'])
            .map((e) => BenifitByDateHour.fromJson(e))
            .toList();
  }
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

    for (var element in listResult) {
      numOrder += element.count;
      numberBuyer += element.buyer;
      totalPrice += element.price;
      totalRevenue += element.revenue;
      totalCost += element.cost;
      totalProfit += element.profit;
      totalShipPrice += element.ship_price;
      totalDiscount += element.discount;
      int ts = extractHourTimeStamp(element.localTime);
      resultMaped[ts] = BenifitByHourOfDateWithOffset(0, ts, data: element);
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
              discount_promotional: 0,
              discount_by_point: 0,
              return_price: 0,
              additional_fee: 0,
              price: 0,
              ship_price: 0,
              discount: 0,
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
    return [];
  }
}

class BenifitByHourOfDateWithOffset implements ReportWithOffset {
  final ReportInterface data;
  int offset;
  final int timeStamp;

  BenifitByHourOfDateWithOffset(this.offset, this.timeStamp,
      {required this.data});

  @override
  set timeStamp(int _timeStamp) {
    // TODO: implement timeStamp
  }

  @override
  set data(ReportInterface _data) {
    // TODO: implement data
  }
}

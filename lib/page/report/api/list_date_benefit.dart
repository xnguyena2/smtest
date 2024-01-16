import 'package:sales_management/component/interface/list_report_interface.dart';
import 'package:sales_management/component/interface/report_interface.dart';
import 'package:sales_management/component/interface/report_with_offset_interface.dart';
import 'package:sales_management/page/home/api/model/benifit_by_date_of_month.dart';
import 'package:sales_management/utils/utils.dart';

class ListDateBenifitDataResult implements ListReportInterface {
  ListDateBenifitDataResult({
    required this.listResult,
  });
  late final List<BenifitByDateOfMonth> listResult;
  late final List<BenifitByDateOfMonthWithOffset> listResultFlat;
  ListDateBenifitDataResult.fromJson(Map<String, dynamic> json) {
    listResult = json['list_result'] == null
        ? []
        : List.from(json['list_result'])
            .map((e) => BenifitByDateOfMonth.fromJson(e))
            .toList();
  }
  int first = 0;
  int last = 0;

  double totalPrice = 0;
  double totalRevenue = 0;
  double totalCost = 0;
  double totalProfit = 0;
  double totalShipPrice = 0;
  double totalDiscount = 0;
  int numberBuyer = 0;
  int numOrder = 0;

  void fillAllEmpty(String from, String to, bool fillAll) {
    first = extractTimeStamp(from);
    last = extractTimeStamp(to);

    Map<int, BenifitByDateOfMonthWithOffset> resultMaped =
        Map<int, BenifitByDateOfMonthWithOffset>();
    numOrder = listResult.fold(
        numberBuyer, (previousValue, element) => previousValue + element.count);
    numberBuyer = listResult.fold(
        0, (previousValue, element) => previousValue + element.buyer);
    listResult.forEach((element) {
      totalPrice += element.price;
      totalRevenue += element.revenue;
      totalCost += element.cost;
      totalProfit += element.profit;
      totalShipPrice += element.ship_price;
      totalDiscount += element.discount;
      int ts = extractTimeStamp(element.localTime);
      resultMaped[ts] = BenifitByDateOfMonthWithOffset(0, ts, data: element);
    });
    int offset = 0;
    for (int i = first; i <= last; i += 86400000) {
      var p = resultMaped[i];
      if (p == null) {
        if (fillAll) {
          resultMaped[i] = BenifitByDateOfMonthWithOffset(
            offset,
            i,
            data: BenifitByDateOfMonth(
              localTime: timeStampToServerFormat(i),
              revenue: 0,
              profit: 0,
              cost: 0,
              count: 0,
              buyer: 0,
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
    final ts = first + offset * 86400000;
    return timeStampToFormat(ts);
  }

  @override
  List<ReportInterface> getListResult() {
    // TODO: implement getListResult
    return listResult;
  }

  @override
  List<ReportWithOffset> getListResultFlat() {
    // TODO: implement getListResultFlat
    return listResultFlat;
  }
}

class BenifitByDateOfMonthWithOffset implements ReportWithOffset {
  final ReportInterface data;
  int offset;
  final int timeStamp;

  BenifitByDateOfMonthWithOffset(this.offset, this.timeStamp,
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

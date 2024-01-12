import 'package:sales_management/page/home/api/model/benifit_by_date_of_month.dart';
import 'package:sales_management/utils/utils.dart';

class ListDateBenifitDataResult {
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
  int firstDate = 0;
  int lastDate = 0;

  double totalRevenue = 0;
  double totalCost = 0;
  double totalProfit = 0;
  int numberBuyer = 0;
  int numOrder = 0;

  void fillAllEmpty(String from, String to) {
    firstDate = extractTimeStamp(from);
    lastDate = extractTimeStamp(to);

    Map<int, BenifitByDateOfMonthWithOffset> resultMaped =
        Map<int, BenifitByDateOfMonthWithOffset>();
    numOrder = listResult.fold(
        numberBuyer, (previousValue, element) => previousValue + element.count);
    numberBuyer = listResult.fold(
        0, (previousValue, element) => previousValue + element.buyer);
    listResult.forEach((element) {
      totalRevenue += element.revenue;
      totalCost += element.cost;
      totalProfit += element.profit;
      int ts = extractTimeStamp(element.localTime);
      resultMaped[ts] =
          BenifitByDateOfMonthWithOffset(0, ts, dateOfMonth: element);
    });
    int offset = 0;
    for (int i = firstDate; i <= lastDate; i += 86400000) {
      var p = resultMaped[i];
      if (p == null) {
        resultMaped[i] = BenifitByDateOfMonthWithOffset(
          offset,
          i,
          dateOfMonth: BenifitByDateOfMonth(
              localTime: timeStampToServerFormat(i),
              revenue: 0,
              profit: 0,
              cost: 0,
              count: 0,
              buyer: 0),
        );
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

  int getTimeStampFrom({required int offset}) {
    return firstDate + offset * 86400000;
  }
}

class BenifitByDateOfMonthWithOffset {
  final BenifitByDateOfMonth dateOfMonth;
  int offset;
  final int timeStamp;

  BenifitByDateOfMonthWithOffset(this.offset, this.timeStamp,
      {required this.dateOfMonth});
}

import 'package:sales_management/component/interface/report_interface.dart';

abstract interface class ReportWithOffset {
  late final ReportInterface data;
  late int offset;
  late final int timeStamp;
}

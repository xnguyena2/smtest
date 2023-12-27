import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

List<T> flatten<T>(Iterable<Iterable<T>> list) =>
    [for (var sublist in list) ...sublist];

DateTime stringToDateTime(String dateValue) {
  return DateFormat("y-MM-ddTHH:mm:ss.S").parse(dateValue, true);
}

String getCreateAtNow() {
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(DateTime.now().toUtc());
}

String getCurrentDateTimeNow() {
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(DateTime.now());
}

String getFirstDateTimeOfCurrentMonth() {
  final now = DateTime.now();
  var date = DateTime(now.year, now.month, 1);
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(date);
}

String getDateinWeekofTimeStamp(String timeStamp) {
  DateTime dt = DateFormat("y-MM-dd").parse(timeStamp);
  return DateFormat('EEEE').format(dt);
}

int extractTimeStamp(String local_time) {
  DateTime dt = DateFormat("y-MM-dd").parse(local_time);
  int ts = (dt.millisecondsSinceEpoch).floor();
  return ts;
}

String timeStampToFormat(int timeStamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat("dd/MM/yy").format(dt);
}

String timeStampToServerFormat(int timeStamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat("y-MM-dd").format(dt);
}

String formatLocalDateTimeOfDateTime(DateTime dateTime) {
  final format = DateFormat('HH:mm dd-MM-yyyy');
  return format.format(dateTime.toLocal());
}

String formatLocalDateTime(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) {
    return 'unknow';
  }
  final format = DateFormat('HH:mm dd-MM-yyyy');
  return format.format(stringToDateTime(dateTime).toLocal());
}

String formatLocalDateTimeOnlyDate(String? dateTime) {
  final format = DateFormat('dd-MM-yyyy');
  return dateTime == null
      ? 'unknow'
      : format.format(stringToDateTime(dateTime).toLocal());
}

String formatLocalDateTimeOnlyTime(String? dateTime) {
  final format = DateFormat('HH:mm');
  return dateTime == null
      ? 'unknow'
      : format.format(stringToDateTime(dateTime).toLocal());
}

String generateUUID() {
  var uuid = Uuid();
  return uuid.v1();
}

double tryParseMoney(String money) {
  return double.tryParse(money.replaceAll(',', '')) ?? 0;
}

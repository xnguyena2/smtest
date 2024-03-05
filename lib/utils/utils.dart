import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

List<T> flatten<T>(Iterable<Iterable<T>> list) =>
    [for (var sublist in list) ...sublist];

DateTime stringToDateTime(String dateValue) {
  return DateFormat("y-MM-ddTHH:mm:ss.S").parse(dateValue, true);
}

DateTime stringTimeZoneToDateTime(String dateValue) {
  return DateFormat("y-MM-ddThh:mm:ss.sssZ").parse(dateValue);
}

DateTime stringToLocalDateTime(String? dateValue) {
  if (dateValue == null || dateValue.isEmpty) {
    return DateTime.now();
  }
  return DateFormat("y-MM-ddTHH:mm:ss.S").parse(dateValue);
}

String localDateTime2ServerToDateTime(DateTime dt) {
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(dt.toUtc());
}

String localDateTime2ServerFormat(DateTime dt) {
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(dt);
}

String getCreateAtNow() {
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(DateTime.now().toUtc());
}

String getLastDateTimeNow() {
  final now = DateTime.now();
  var date = DateTime(now.year, now.month, now.day);
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(date);
}

String getCurrentDateTimeNow() {
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(DateTime.now());
}

String getFirstDateTimeOfCurrentMonth() {
  final now = DateTime.now();
  var date = DateTime(now.year, now.month, 1);
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(date);
}

String getFirstDateTimeOfLastMonth() {
  final now = DateTime.now();
  var date = DateTime(now.year, now.month - 1, 1);
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(date);
}

String getLastDateTimeOfLastMonth() {
  final now = DateTime.now();
  var date = DateTime(now.year, now.month, 0, 24);
  return DateFormat("y-MM-ddTHH:mm:ss.S").format(date);
}

String getDateinWeekofTimeStampToLocal(String? timeStamp) {
  if (timeStamp == null || timeStamp.isEmpty) {
    return 'unknow';
  }
  DateTime dt = DateFormat("y-MM-dd").parse(timeStamp).toLocal();
  // String locale = Localizations.localeOf(context).languageCode;
  return DateFormat.EEEE('vi').format(dt);
}

int extractTimeStamp(String local_time) {
  DateTime dt = DateFormat("y-MM-dd").parse(local_time);
  int ts = (dt.millisecondsSinceEpoch).floor();
  return ts;
}

int extractHourTimeStamp(String local_time) {
  DateTime dt = DateFormat("y-MM-ddTHH:mm:ss").parse(local_time);
  int ts = (dt.millisecondsSinceEpoch).floor();
  return ts;
}

int extractTimeStampToLocal(String local_time) {
  DateTime dt = DateFormat("y-MM-dd").parse(local_time).toLocal();
  int ts = (dt.millisecondsSinceEpoch).floor();
  return ts;
}

int currentTimeStampLocal() {
  DateTime dt = DateTime.now();
  int ts = (dt.millisecondsSinceEpoch).floor();
  return ts;
}

String timeStampToFormat(int timeStamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat("dd/MM/yy").format(dt);
}

String timeStampToHourFormat(int timeStamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return '${DateFormat("HH").format(dt)}h';
}

String formatLocalDateTimeOnlyDateSplashFromDate(DateTime dateTime) {
  final format = DateFormat('dd/MM/yyyy');
  return format.format(dateTime.toLocal());
}

String formatLocalDateTimeOnlyDateSplash(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) {
    return 'unknow';
  }
  final format = DateFormat('dd/MM/yyyy');
  return format.format(stringToDateTime(dateTime).toLocal());
}

String formatDateTimeOnlyDateSplash(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) {
    return 'unknow';
  }
  final format = DateFormat('dd/MM/yyyy');
  return format.format(stringToDateTime(dateTime));
}

String timeStampToServerFormat(int timeStamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat("y-MM-dd").format(dt);
}

String timeHourStampToServerFormat(int timeStamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat("y-MM-ddTHH:mm:ss").format(dt);
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

String formatSplashLocalDateTime(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) {
    return 'unknow';
  }
  final format = DateFormat('HH:mm dd/MM/yyyy');
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

int tryParseNumber(String number) {
  return int.tryParse(number.replaceAll(',', '')) ?? 0;
}

bool listenConnection(ConnectivityResult connectivityResult) {
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    return true;
  } else if (connectivityResult == ConnectivityResult.vpn) {
    return true;
  }
  return false;
}

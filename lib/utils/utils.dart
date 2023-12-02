import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

List<T> flatten<T>(Iterable<Iterable<T>> list) =>
    [for (var sublist in list) ...sublist];

DateTime stringToDateTime(String dateValue) {
  return DateFormat("y-MM-ddThh:mm:ss.S").parse(dateValue, true);
}

String getCreateAtNow() {
  return DateFormat("y-MM-ddThh:mm:ss.S").format(DateTime.now().toUtc());
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

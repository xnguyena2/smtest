import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

List<T> flatten<T>(Iterable<Iterable<T>> list) =>
    [for (var sublist in list) ...sublist];

DateTime stringToDateTime(String dateValue) {
  return DateFormat("y-MM-ddThh:mm:ss.S").parse(dateValue, true);
}

String formatLocalDateTime(String? dateTime) {
  final format = DateFormat('HH:mm dd-MM-yyyy');
  return dateTime == null
      ? 'unknow'
      : format.format(stringToDateTime(dateTime).toLocal());
}

String generateUUID() {
  var uuid = Uuid();
  return uuid.v1();
}

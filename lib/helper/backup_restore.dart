import 'package:sales_management/utils/typedef.dart';

class BackupRestore<T, R> {
  final ReturnCallbackArg<T, R> backup;

  final VoidCallbackArg<R> restore;

  final ReturnCallbackAsync<bool> mainAction;

  BackupRestore({
    required this.backup,
    required this.restore,
    required this.mainAction,
  });

  Future<void> action(T object) async {
    final img = backup(object);
    final shouldRestore = await mainAction();
    if (shouldRestore) {
      restore(img);
    }
  }
}

import 'package:flutter/material.dart';

class StateAreaTable extends InheritedWidget {
  const StateAreaTable({
    super.key,
    required this.data,
    required super.child,
  });

  final String data;

  static StateAreaTable? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateAreaTable>();
  }

  static StateAreaTable of(BuildContext context) {
    final StateAreaTable? result = maybeOf(context);
    assert(result != null, 'No StateAreTable found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StateAreaTable oldWidget) {
    return data != oldWidget.data;
  }
}

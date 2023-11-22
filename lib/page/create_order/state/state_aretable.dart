import 'package:flutter/material.dart';

class StateAreaTable extends InheritedWidget {
  final String data;
  final String totalPrice;
  final String finalPrice;
  final int numItems;

  const StateAreaTable({
    super.key,
    required this.totalPrice,
    required this.data,
    required super.child,
    required this.numItems,
    required this.finalPrice,
  });

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
    return data != oldWidget.data ||
        totalPrice != oldWidget.totalPrice ||
        numItems != oldWidget.numItems ||
        finalPrice != oldWidget.finalPrice;
  }
}

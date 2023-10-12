import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

void showNotification(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: TableHighColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showAlert(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: Red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

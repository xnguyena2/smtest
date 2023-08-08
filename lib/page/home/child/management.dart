import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_management/utils/constants.dart';

import '../compoment/guide.dart';
import '../compoment/main_function.dart';
import '../compoment/monthly_report.dart';
import '../compoment/quick_report.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          QuickReport(),
          Guide(),
          MainFunction(),
          AspectRatio(
            aspectRatio: 1.23,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 6),
              child: MonthlyReport(),
            ),
          ),
          SizedBox(
            height: 2000,
          )
        ],
      ),
    );
  }
}

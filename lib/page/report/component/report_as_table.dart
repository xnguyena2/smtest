import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

enum HeaderReportType { MAIN, SUB }

class ReportItem {
  final HeaderReportType reportType;

  final String header;
  final String value;

  ReportItem(
      {required this.reportType, required this.header, required this.value});
}

class ReportAsTable extends StatelessWidget {
  final String header;
  final List<ReportItem> datas;
  const ReportAsTable({
    super.key,
    required this.datas,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            '$header',
            style: headStyleLargeBlackLigh,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: BackgroundColor,
            dividerTheme: const DividerThemeData(
              color: BackgroundColor,
              space: 0,
              thickness: 0,
              indent: 0,
              endIndent: 0,
            ),
          ),
          child: DataTable(
            horizontalMargin: 12,
            decoration: const BoxDecoration(
              color: White,
            ),
            headingRowHeight: 0,
            dividerThickness: 0,
            border: TableBorder.symmetric(
                inside: const BorderSide(width: 1.5, color: BackgroundColor)),
            columns: const [
              DataColumn(label: SizedBox()),
              DataColumn(label: SizedBox()),
            ],
            rows: datas
                .map(
                  (e) => DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Row(
                          children: [
                            if (e.reportType == HeaderReportType.SUB)
                              const SizedBox(
                                width: 20,
                              ),
                            Text(
                              e.header,
                              style: e.reportType == HeaderReportType.SUB
                                  ? subInfoStyLargeLigh400
                                  : subInfoStyLarge400,
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              e.value,
                              style: headStyleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

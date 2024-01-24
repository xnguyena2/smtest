import 'package:flutter/material.dart';
import 'package:sales_management/page/home/api/model/benifit_by_product_of_month.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class ReportByProductLastTimeAsTable extends StatelessWidget {
  final List<BenifitByProduct> benifitByProducts;
  const ReportByProductLastTimeAsTable({
    super.key,
    required this.benifitByProducts,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: White,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Top 3 sản phẩm mua nhiều',
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
              headingTextStyle: subInfoStyLarge400,
              decoration: const BoxDecoration(
                color: White,
              ),
              dividerThickness: 0,
              border: TableBorder.symmetric(
                  inside: const BorderSide(width: 1.5, color: BackgroundColor)),
              columns: const [
                DataColumn(label: Text('SẢN PHẨM')),
                DataColumn(label: Text('SL')),
                DataColumn(label: Text('GẦN NHẤT')),
              ],
              rows: benifitByProducts
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${e.product_name}',
                              style: headStyleMedium,
                            ),
                            if (e.product_unit_name?.isNotEmpty == true)
                              Text(
                                '${e.product_unit_name}',
                                style: subStyleMediumNormalLight,
                              ),
                          ],
                        )),
                        DataCell(
                          Text(
                            e.number_unit.toString(),
                            style: headStyleMedium,
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                formatLocalDateTimeOnlyDateSplash(e.createat),
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
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

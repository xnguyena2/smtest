import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/page/table/table_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class SelectAreaAndDeliver extends StatefulWidget {
  final PackageDataResponse data;
  const SelectAreaAndDeliver({
    super.key,
    required this.data,
  });

  @override
  State<SelectAreaAndDeliver> createState() => _SelectAreaAndDeliverState();
}

class _SelectAreaAndDeliverState extends State<SelectAreaAndDeliver> {
  late DeliverType currentPackgeType;
  late bool isEatAtTable;
  late PackageDataResponse data;
  late bool isDone = data.isDone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    currentPackgeType = data.packageType;
    isEatAtTable = currentPackgeType == DeliverType.table;
  }

  @override
  Widget build(BuildContext context) {
    onChanged(value) {
      setState(() {
        currentPackgeType = value ?? DeliverType.table;
        data.packageType = currentPackgeType;
        isEatAtTable = currentPackgeType == DeliverType.table;
        context.read<ProductProvider>().justRefresh();
      });
    }

    return DefaultPaddingContainer(
      child: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckRadioItem<DeliverType>(
                txt: 'Ăn tại bàn',
                groupValue: currentPackgeType,
                value: DeliverType.table,
                isDisable: isDone,
                onChanged: onChanged,
              ),
              CheckRadioItem<DeliverType>(
                txt: 'Mang về',
                groupValue: currentPackgeType,
                value: DeliverType.takeaway,
                isDisable: isDone,
                onChanged: onChanged,
              ),
              CheckRadioItem<DeliverType>(
                txt: 'Giao hàng',
                groupValue: currentPackgeType,
                value: DeliverType.deliver,
                isDisable: isDone,
                onChanged: onChanged,
              )
            ],
          ),
          if (isEatAtTable && !isDone) ...[
            const SizedBox(
              height: 7,
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TablePage(
                      done: (table) {
                        table.packageSecondId = data.packageSecondId;
                        data.areaId = table.areaId;
                        data.areaName = table.detail;
                        data.tableId = table.tableId;
                        data.tableName = table.tableName;
                        data.setAction(() => setPackageId(table));
                      },
                    ),
                  ),
                );
                context.read<ProductProvider>().justRefresh();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: SelectTableBackgroundColor,
                    borderRadius: defaultSquareBorderRadius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chọn bàn:',
                      style: subStyleMediumNormalLight,
                    ),
                    Row(
                      children: [
                        Text(
                          data.areAndTable,
                          style: headStyleMedium,
                        ),
                        LoadSvg(
                          assetPath: 'svg/navigate_next.svg',
                          color: Black,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

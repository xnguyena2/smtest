import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

enum DeliverType { deliver, takeaway, table }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    currentPackgeType = DeliverType.values.firstWhere(
        (element) => element.name == data.packageType,
        orElse: () => DeliverType.table);
    isEatAtTable = currentPackgeType == DeliverType.table;
  }

  @override
  Widget build(BuildContext context) {
    void Function(DeliverType?) onChanged = (value) {
      print(value);
      setState(() {
        currentPackgeType = value ?? DeliverType.table;
        data.packageType = currentPackgeType.name;
        isEatAtTable = currentPackgeType == DeliverType.table;
      });
    };

    return DefaultPaddingContainer(
      child: Column(
        children: [
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckRadioItem<DeliverType>(
                txt: 'Ăn tại bàn',
                groupValue: currentPackgeType,
                value: DeliverType.table,
                onChanged: onChanged,
              ),
              CheckRadioItem<DeliverType>(
                txt: 'Mang về',
                groupValue: currentPackgeType,
                value: DeliverType.takeaway,
                onChanged: onChanged,
              ),
              CheckRadioItem<DeliverType>(
                txt: 'Giao hàng',
                groupValue: currentPackgeType,
                value: DeliverType.deliver,
                onChanged: onChanged,
              )
            ],
          ),
          if (isEatAtTable) ...[
            SizedBox(
              height: 7,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: SelectTableBackgroundColor,
                    borderRadius: defaultSquareBorderRadius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                          colorFilter: const ColorFilter.mode(
                            Black,
                            BlendMode.srcIn,
                          ),
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

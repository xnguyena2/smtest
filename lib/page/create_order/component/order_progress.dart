import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/utils.dart';

class Progress extends StatelessWidget {
  final PackageDataResponse data;
  const Progress({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool isDone = data.isDone;
    return DefaultPaddingContainer(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: ProgressItem(
            isDone: true,
            isFirst: true,
            txt: 'Chờ xác nhận',
            subTxt: '',
          )),
          Expanded(
              child: ProgressItem(
            isDone: true,
            txt: 'Đang xử lý',
            subTxt: formatLocalDateTime(data.createat),
          )),
          Expanded(
              child: ProgressItem(
            isDone: isDone,
            isLast: true,
            txt: 'Đã giao',
            subTxt: isDone ? formatLocalDateTime(data.getDoneTime()) : '',
          )),
        ],
      ),
    ));
  }
}

class ProgressItem extends StatelessWidget {
  final bool isDone;
  final String txt;
  final String subTxt;
  final bool isFirst;
  final bool isLast;
  ProgressItem({
    super.key,
    required this.isDone,
    required this.txt,
    required this.subTxt,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: isFirst
                    ? SizedBox()
                    : Divider(
                        color: HighColor,
                      )),
            isDone
                ? LoadSvg(assetPath: 'svg/check.svg')
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 5,
                    ),
                  ),
            Expanded(
                child: isLast
                    ? SizedBox()
                    : Divider(
                        color: HighColor,
                      ))
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          txt,
          style: headStyleMedium,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          subTxt,
          style: subInfoStyMedium400Light,
        ),
      ],
    );
  }
}

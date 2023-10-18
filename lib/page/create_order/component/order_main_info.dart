import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/page/create_order/state/state_aretable.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class OrderMainInfo extends StatelessWidget {
  final PackageDataResponse data;
  const OrderMainInfo({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool isDone = data.isDone;
    return DefaultPaddingContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'ID: ${data.id}',
                    style: headStyleXLarge400,
                  ),
                  SizedBox(
                    width: 8.5,
                  ),
                  LoadSvg(assetPath: 'svg/copy.svg', width: 15, height: 15)
                ],
              ),
              TextRound(
                txt: isDone ? 'Đã giao' : 'Đang xử lý',
                isHigh: isDone,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            data.localTimeTxt,
            style: subStyleMediumNormalLight,
          ),
          SizedBox(
            height: 7,
          ),
          Divider(),
          SizedBox(
            height: 5,
          ),
          AreaTableInfo(),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.priceFormat,
                style: moneyStyleSuperLarge,
              ),
              ApproveBtn(
                txt: 'Gửi hóa đơn',
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            isDone ? 'Đã thanh toán' : 'Chưa thanh toán',
            style: isDone ? headStyleMediumHigh500 : headStyleMediumAlert500,
          )
        ],
      ),
    );
  }
}

class AreaTableInfo extends StatelessWidget {
  const AreaTableInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String areaTable = StateAreaTable.of(context).data;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      decoration: BoxDecoration(
        color: BackgroundHigh,
        borderRadius: defaultSquareBorderRadius,
      ),
      child: Row(
        children: [
          Text(
            areaTable,
            style: subInfoStyLarge500High,
          ),
        ],
      ),
    );
  }
}

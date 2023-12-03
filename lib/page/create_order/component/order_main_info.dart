import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class OrderMainInfo extends StatelessWidget {
  const OrderMainInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PackageDataResponse data = context.watch<ProductProvider>().getPackage!;
    PaymentStatus status = data.paymentStatus();
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
          AreaTableInfo(
            data: data,
          ),
          SizedBox(
            height: 4,
          ),
          TotalPriceInfo(data: data),
          SizedBox(
            height: 8,
          ),
          Text(
            status == PaymentStatus.DONE
                ? 'Đã thanh toán'
                : status == PaymentStatus.MAKE_SOME_PAY
                    ? 'Thanh toán một phần'
                    : 'Chưa thanh toán',
            style: status == PaymentStatus.DONE
                ? headStyleMediumHigh500
                : headStyleMediumAlert500,
          )
        ],
      ),
    );
  }
}

class TotalPriceInfo extends StatelessWidget {
  final PackageDataResponse data;

  const TotalPriceInfo({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String totalPrice = MoneyFormater.format(data.finalPrice);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          totalPrice,
          style: moneyStyleSuperLarge,
        ),
        ApproveBtn(
          txt: 'Gửi hóa đơn',
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          onPressed: () {},
        ),
      ],
    );
  }
}

class AreaTableInfo extends StatelessWidget {
  final PackageDataResponse data;

  const AreaTableInfo({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String areaTable = data.areAndTable;
    if (areaTable == 'NOT') return SizedBox();
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

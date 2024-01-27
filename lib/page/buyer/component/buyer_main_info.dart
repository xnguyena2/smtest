import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/reciver_info.dart';
import 'package:sales_management/page/buyer/component/total_item_report.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class BuyerMainInfo extends StatefulWidget {
  const BuyerMainInfo({
    super.key,
    required this.buyerData,
  });

  final BuyerData buyerData;

  @override
  State<BuyerMainInfo> createState() => _BuyerMainInfoState();
}

class _BuyerMainInfoState extends State<BuyerMainInfo> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      color: White,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin',
                style: customerNameBig600,
              ),
              if (!widget.buyerData.isUnknowUser)
                GestureDetector(
                  onTap: () async {
                    AddressData addressData =
                        AddressData.fromBuyerData(widget.buyerData);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReciverInfo(
                          addressData: addressData,
                          done: (data) {
                            addressData = data;
                            widget.buyerData.updateData(addressData);
                          },
                          delete: () {},
                          isEdit: false,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  child: Text(
                    'xem thêm >',
                    style: customerNameBigHigh600,
                  ),
                )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              LoadSvg(assetPath: 'svg/label.svg'),
              SizedBox(
                width: 8,
              ),
              Text(
                'Nhãn:',
                style: headStyleSemiLarge400,
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Black15,
                  borderRadius: bigRoundBorderRadius,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: TableHighColor,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'Khách hàng tiềm năng',
                      style: headStyleSemiLargeLigh400,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: TotalReportItem(
                  iconPath: 'svg/ecommerce_money.svg',
                  headerTxt: 'Tổng doanh thu',
                  contentTxt: MoneyFormater.format(widget.buyerData.realPrice),
                  maxWidth: (screenWidth - 32 - 20 - 24) / 2 - 41,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TotalReportItem(
                  iconPath: 'svg/discount_ecommerce_price.svg',
                  headerTxt: 'Tổng tiền đã giảm',
                  contentTxt: MoneyFormater.format(widget.buyerData.discount),
                  maxWidth: (screenWidth - 32 - 20 - 24) / 2 - 41,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          TotalReportItem(
            bgColor: White,
            iconPath: 'svg/points_and_dollars_exchange.svg',
            headerTxt: 'Điểm tích lỹ quy đổi(100k = 1 điểm)',
            maxWidth: (screenWidth - 32 - 24),
            contentTxt:
                '${MoneyFormater.format(widget.buyerData.realPrice)} - ${MoneyFormater.format(widget.buyerData.discount)} = ${((widget.buyerData.realPrice - widget.buyerData.discount) / 100000).toInt()} điểm',
          ),
          SizedBox(
            height: 30,
          ),
          TotalReportItem(
            bgColor: White,
            iconPath: 'svg/point.svg',
            headerTxt: 'Tổng điểm còn lại sau khi dùng',
            maxWidth: (screenWidth - 32 - 24),
            contentTxt:
                '${((widget.buyerData.realPrice - widget.buyerData.discount) / 100000).toInt()} - ${-widget.buyerData.point} = ${widget.buyerData.getTotalPoint} điểm',
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

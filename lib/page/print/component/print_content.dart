import 'package:flutter/material.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/line/dash.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/utils.dart';

class PrintContent extends StatelessWidget {
  const PrintContent({
    super.key,
    required this.data,
    required this.store,
  });

  final PackageDataResponse data;
  final Store? store;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      color: White,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${store?.name}',
                    style: totalMoneyHeaderStylexxXLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'SDT: ${store?.phone}',
                    style: headStyleXLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    softWrap: true,
                    text: TextSpan(
                        text: 'Địa chỉ: ',
                        style: headStyleSemiLarge500,
                        children: [
                          TextSpan(
                            text: store?.address ?? '',
                            style: customerNameBig,
                          )
                        ]),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            color: Black,
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            children: [
              Text(
                'HÓA ĐƠN BÁN HÀNG',
                style: totalMoneyStylexxXLargeBlack,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${data.getID} - ${formatSplashLocalDateTime(data.createat)}',
                style: headStyleXLarge400,
              ),
              if (data.buyer?.isUnknowUser == false) ...[
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Khách:',
                      style: headStyleXLarge400,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.buyer?.reciverFullname ?? 'Khách lẻ'}',
                            style: headStyleXLarge400,
                          ),
                          if (data.buyer?.phoneNumber != null) ...[
                            SizedBox(
                              height: 2,
                            ),
                            Text('${data.buyer?.phoneNumber}',
                                style: headStyleXLarge400),
                          ],
                          if (data.buyer?.getAddressFormatNullable() !=
                              null) ...[
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              '${data.buyer?.getAddressFormatNullable()}',
                              style: headStyleXLarge400,
                              softWrap: true,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                )
              ],
              if (data.areAndTable != 'NOT') ...[
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data.areAndTable,
                      style: headStyleXLargeSemiBold,
                    )
                  ],
                )
              ],
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            color: Black,
          ),
          SizedBox(
            height: 12,
          ),
          DataTable(
            horizontalMargin: 0,
            headingTextStyle: subInfoStyLarge400,
            headingRowHeight: 0,
            decoration: const BoxDecoration(
              color: White,
            ),
            dividerThickness: 0,
            border: TableBorder.symmetric(
                inside: const BorderSide(width: 1.5, color: BackgroundColor)),
            columns: const [
              DataColumn(label: SizedBox()),
              DataColumn(label: SizedBox()),
              DataColumn(label: SizedBox()),
            ],
            rows: [
              const DataRow(cells: [
                DataCell(Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ĐƠN GIÁ',
                      style: headStyleXXLarge,
                    ),
                  ],
                )),
                DataCell(
                  Text(
                    'SL',
                    style: headStyleXXLarge,
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'T.tiền',
                        style: headStyleXXLarge,
                      ),
                    ],
                  ),
                ),
              ]),
              ...data.items
                  .asMap()
                  .entries
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${e.key + 1}. ${e.value.get_show_name}',
                                style: customerNameBig400,
                              ),
                              Text(
                                MoneyFormater.format(e.value.price),
                                style: customerNameBig400,
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'x${e.value.numberUnit}',
                                style: customerNameBig400,
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    MoneyFormater.format(
                                        e.value.totalPriceDiscount),
                                    style: customerNameBig,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList()
            ],
          ),
          SizedBox(
            height: 12,
          ),
          CustomPaint(
            painter: DashedLinePainter(
              dashWidth: 8,
              dashSpace: 2,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng giá',
                    style: headStyleXLarge400,
                  ),
                  Text(
                    '${data.totalPriceFormat} đ',
                    style: headStyleXLarge400,
                  )
                ],
              ),
              if (data.orderDiscount > 0) ...[
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giảm giá',
                      style: headStyleXLarge400,
                    ),
                    Text(
                      '- ${data.orderDiscountFormat} đ',
                      style: headStyleXLarge400,
                    )
                  ],
                ),
              ],
              if (data.shipPrice > 0) ...[
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phí Ship',
                      style: headStyleXLarge400,
                    ),
                    Text(
                      '${MoneyFormater.format(data.shipPrice)} đ',
                      style: headStyleXLarge400,
                    )
                  ],
                ),
              ],
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng',
                    style: headStylexXXLarge,
                  ),
                  Text(
                    '${data.finalPriceFormat} đ',
                    style: headStylexXXLarge,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Khách trả',
                    style: headStylexXXLarge,
                  ),
                  Text(
                    '${MoneyFormater.format(data.payment)} đ',
                    style: headStylexXXLarge,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          CustomPaint(
            painter: DashedLinePainter(
              dashWidth: 8,
              dashSpace: 2,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (data.finalPrice).toInt().toVietnameseWords(),
                style: headStyleXXLarge400,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          CustomPaint(
            painter: DashedLinePainter(
              dashWidth: 8,
              dashSpace: 2,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bán hàng chuyên nghiệp bằng ứng dụng',
                style: headStyleSemiLargeLigh500,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadSvg(assetPath: 'svg/logo_50.svg'),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Sổ Điện Tử',
                    style: appNameInBillStylexxXLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Cảm ơn quý khách và hẹn gặp lại!',
                style: goobyeBillStylexxXLargeBlack,
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

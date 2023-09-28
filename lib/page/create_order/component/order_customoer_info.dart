import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/reciver_info.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class CustomerInfo extends StatefulWidget {
  final PackageDataResponse data;
  const CustomerInfo({
    super.key,
    required this.data,
  });

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  @override
  Widget build(BuildContext context) {
    BuyerData? buyer = widget.data.buyer;
    String? regionTextFormat = buyer?.region != null
        ? '${buyer?.reciverAddress ?? ''}, ${buyer?.ward ?? ''}, ${buyer?.district ?? ''}, ${buyer?.region ?? ''}'
        : null;

    return DefaultPaddingContainer(
      child: Column(
        children: [
          SizedBox(
            height: 11,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: borderColor,
                child: CircleAvatar(
                  backgroundColor: White,
                  radius: 24,
                  child: LoadSvg(assetPath: 'svg/profile_round.svg'),
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        buyer?.reciverFullname ?? 'Khách lẻ',
                        style: customerNameBig,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      LoadSvg(assetPath: 'svg/copy.svg', width: 15, height: 15),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    buyer?.phoneNumber ?? '',
                    style: headStyleSemiLargeLigh500,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () async {
              AddressData addressData =
                  AddressData.fromBuyerData(widget.data.buyer);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReciverInfo(
                    addressData: addressData,
                    done: () {
                      widget.data.buyer?.updateData(addressData);
                    },
                    delete: () {},
                    isEdit: false,
                  ),
                ),
              );
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    regionTextFormat ?? 'Nhập địa chỉ',
                    style: customerNameBigLigh,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 11,
          ),
        ],
      ),
    );
  }
}

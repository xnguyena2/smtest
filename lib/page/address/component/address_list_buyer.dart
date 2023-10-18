import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/api/model/list_buyer.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class ListBuyer extends StatelessWidget {
  final VoidCallbackArg<AddressData> onSelected;
  const ListBuyer({
    super.key,
    required this.loadingListBuyer,
    required this.onSelected,
  });

  final Future<ListBuyerResult> loadingListBuyer;

  @override
  Widget build(BuildContext context) {
    return FetchAPI<ListBuyerResult>(
      future: loadingListBuyer,
      successBuilder: (listBuyerResult) {
        final listBuyer = listBuyerResult.listResult;
        return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final buyer = listBuyer[index];
              return GestureDetector(
                onTap: () {
                  final addressData = AddressData.fromBuyerData(buyer);
                  onSelected(addressData);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      foregroundImage: AssetImage(
                        "assets/images/shop_logo_big.png",
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          buyer.reciverFullname ?? 'Khách lẻ',
                          style: headStyleSemiLarge500,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          buyer.phoneNumber ?? '',
                          style: headStyleSemiLargeLigh500,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: listBuyer.length);
      },
    );
  }
}

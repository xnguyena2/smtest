import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/reciver_info.dart';
import 'package:sales_management/page/buyer/buyer_detail_page.dart';
import 'package:sales_management/page/list_buyer/api/list_buyer_api.dart';
import 'package:sales_management/page/list_buyer/api/model/list_buyer.dart';
import 'package:sales_management/page/list_buyer/component/list_buyer_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ListBuyerPage extends StatefulWidget {
  const ListBuyerPage({super.key});

  @override
  State<ListBuyerPage> createState() => _ListBuyerPageState();
}

class _ListBuyerPageState extends State<ListBuyerPage> {
  ListBuyerDataResult? listBuyerDataResult;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: White,
        appBar: ListBuyerBar(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton.small(
            elevation: 2,
            backgroundColor: MainHighColor,
            shape: RoundedRectangleBorder(
              borderRadius: floatBottomBorderRadius,
            ),
            onPressed: () {
              AddressData addressData = AddressData.fromBuyerData(null);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReciverInfo(
                    addressData: addressData,
                    done: (data) {
                      final buyerData =
                          BuyerData(region: '', district: '', ward: '');
                      buyerData.updateData(data);
                      listBuyerDataResult?.listResult.add(buyerData);
                      setState(() {});
                    },
                    delete: () {},
                    isEdit: false,
                  ),
                ),
              );
            },
            child: LoadSvg(
              assetPath: 'svg/plus_large_width_2.svg',
              color: White,
            ),
          );
        }),
        body: FetchAPI<ListBuyerDataResult>(
          future: listBuyerDataResult == null
              ? getAllBuyer()
              : Future.value(listBuyerDataResult),
          successBuilder: (ListBuyerDataResult) {
            listBuyerDataResult = ListBuyerDataResult;
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final buyer = ListBuyerDataResult.listResult[index];
                return _BuyerItems(buyer: buyer);
              },
              itemCount: ListBuyerDataResult.listResult.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Black40,
                  thickness: 0.6,
                  height: 0.6,
                  indent: 97,
                  endIndent: 20,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _BuyerItems extends StatefulWidget {
  const _BuyerItems({
    super.key,
    required this.buyer,
  });

  final BuyerData buyer;

  @override
  State<_BuyerItems> createState() => _BuyerItemsState();
}

class _BuyerItemsState extends State<_BuyerItems> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyerDetail(
              buyer: widget.buyer,
              onUpdate: (BuyerData) {
                setState(() {});
              },
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: BackgroundColor,
              radius: 30,
              child: LoadSvg(assetPath: 'svg/buyer_group.svg'),
            ),
            SizedBox(
              width: 17,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.buyer.reciverFullname}',
                  style: headStyleSemiLarge500,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${widget.buyer.phoneNumber}',
                  style: headStyleSemiLargeSLigh500,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

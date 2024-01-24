import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/buyer/buyer_detail_page.dart';
import 'package:sales_management/page/list_buyer/api/list_buyer_api.dart';
import 'package:sales_management/page/list_buyer/api/model/list_buyer.dart';
import 'package:sales_management/page/list_buyer/component/list_buyer_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ListBuyerPage extends StatelessWidget {
  const ListBuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: White,
        appBar: ListBuyerBar(),
        body: FetchAPI<ListBuyerDataResult>(
          future: getAlBuyer(),
          successBuilder: (ListBuyerDataResult) {
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

class _BuyerItems extends StatelessWidget {
  const _BuyerItems({
    super.key,
    required this.buyer,
  });

  final BuyerData buyer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyerDetail(
              buyer: buyer,
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
                  '${buyer.reciverFullname}',
                  style: headStyleSemiLarge500,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${buyer.phoneNumber}',
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

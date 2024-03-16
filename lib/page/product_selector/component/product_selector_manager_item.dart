import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/utils/constants.dart';

class ProductManagerItem extends StatelessWidget {
  final BeerSubmitData productData;
  const ProductManagerItem({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    final imgUrl = productData.getFristLargeImg;
    final name = productData.name;
    final rangePriceWithOrgPrice = productData.getRangePriceWithOriginPrice;
    final inventoryNum = productData.getTotalInventory;
    final totalCateNum = productData.getTotalCateNum;
    final isAvariable = productData.isAvariable;

    return Container(
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size.fromHeight(70)),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: defaultBorder,
                    color: BackgroundColor,
                    borderRadius: defaultBorderRadius,
                    image: DecorationImage(
                      image: (imgUrl == null
                          ? const AssetImage(
                              'assets/images/product.png',
                            )
                          : NetworkImage(imgUrl)) as ImageProvider,
                    ),
                  ),
                  child: !isAvariable
                      ? Container(
                          decoration: BoxDecoration(
                            color: White70,
                            borderRadius: defaultBorderRadius,
                          ),
                          child: const Center(
                            child: Text(
                              'Hết hàng',
                              style: subInfoStyMedium400,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      name,
                      style: headStyleSemiLarge500,
                    ),
                    Row(
                      children: [
                        if (inventoryNum > 0)
                          Text(
                            'Có thể bán: ${inventoryNum}',
                            style: headStyleMediumNormalLight,
                          ),
                        if (inventoryNum > 0 && totalCateNum > 0)
                          const SizedBox(
                            height: 12,
                            child: VerticalDivider(),
                          ),
                        if (totalCateNum > 0) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: defaultBorderRadius,
                                color: BackgroundHigh),
                            child: Text(
                              '$totalCateNum phân loại',
                              style: subInfoStyLargeLigh400,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          rangePriceWithOrgPrice.isNotEmpty
                              ? rangePriceWithOrgPrice.first
                              : 'unknow',
                          style: isAvariable
                              ? headStyleSemiLargeHigh500
                              : headStyleSemiLargeLigh500,
                        ),
                        if (rangePriceWithOrgPrice.length > 1) ...[
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            rangePriceWithOrgPrice[1],
                            style: headStyleSemiLargeVeryLigh500LineThrough,
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

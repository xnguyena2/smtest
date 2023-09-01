import 'package:flutter/material.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Khách lẻ',
                style: customerNameBig,
              ),
              SizedBox(
                width: 4,
              ),
              LoadSvg(assetPath: 'svg/copy.svg', width: 15, height: 15),
            ],
          ),
          SizedBox(
            height: 11,
          ),
        ],
      ),
    );
  }
}

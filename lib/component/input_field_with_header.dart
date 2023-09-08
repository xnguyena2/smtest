import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class InputFiledWithHeader extends StatelessWidget {
  final String header;
  final bool isImportance;
  final String hint;
  const InputFiledWithHeader({
    super.key,
    required this.header,
    required this.hint,
    this.isImportance = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    header,
                    style: headStyleBigMedium,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  isImportance
                      ? Text(
                          '*',
                          style: headStyleSemiLargeAlert500,
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Black40),
                  ),
                ),
                child: TextField(
                  maxLines: 1,
                  style: customerNameBig400,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    hintStyle: customerNameBigLight400,
                    hintText: hint,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

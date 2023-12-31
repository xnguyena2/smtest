import 'package:flutter/material.dart';
import 'package:sales_management/component/header.dart';
import 'package:sales_management/utils/constants.dart';
// ignore: unused_import
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class IncomeOutComeBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallbackArg<DateTimeRange> onChagneDateTime;
  const IncomeOutComeBar({super.key, required this.onChagneDateTime});

  @override
  State<IncomeOutComeBar> createState() => _IncomeOutComeBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _IncomeOutComeBarState extends State<IncomeOutComeBar> {
  String currentRange = 'Tháng này';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: White,
      child: Header(
        title: 'Thu chi',
        funcWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: GestureDetector(
            onTap: () async {
              DateTimeRange? dt = await showDateRangePicker(
                  context: context,
                  locale: const Locale("vi", "VN"),
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 300.0,
                        ),
                        child: child,
                      ),
                    );
                  });
              if (dt != null) {
                widget.onChagneDateTime(dt);
                currentRange =
                    '${formatLocalDateTimeOnlyDateSplashFromDate(dt.start)} - ${formatLocalDateTimeOnlyDateSplashFromDate(dt.end)}';
                setState(() {});
              }
            },
            child: Row(
              children: [
                LoadSvg(assetPath: 'svg/calendar_date.svg'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  currentRange, //'${getDateinWeekofTimeStampToLocal(transaction.createat)}, ${formatLocalDateTimeOnlyDateSplash(transaction.createat)}',
                  style: customerNameBigHight,
                ),
                SizedBox(
                  width: 2,
                ),
                LoadSvg(assetPath: 'svg/down_chevron.svg')
              ],
            ),
          ),
        ),
        extendsWidget: SizedBox(),
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

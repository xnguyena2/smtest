import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class TimeSelector extends StatefulWidget {
  final VoidCallbackArg<DateTimeRange> onChagneDateTime;
  final VoidCallbackArg<List<String>> onChangeTime;
  static const List<String> listTime = [
    'Hôm nay',
    'Tháng này',
    'Tháng trước'
  ];
  const TimeSelector({
    super.key,
    required this.onChagneDateTime,
    required this.onChangeTime,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String currentRange = 'Tháng này';
  void ontap(String value) {
    currentRange = value;
    if (currentRange == 'Hôm nay') {
      widget.onChangeTime(
          [getLastDateTimeNow(), getCurrentDateTimeNow(), 'today']);
      setState(() {});
      return;
    }
    if (currentRange == 'Tháng này') {
      widget.onChangeTime(['', '']);
      setState(() {});
      return;
    }
    if (currentRange == 'Tháng trước') {
      widget.onChangeTime(
          [getFirstDateTimeOfLastMonth(), getLastDateTimeOfLastMonth()]);
      setState(() {});
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool usingCustomeTime = currentRange.contains(' - ');
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                GestureDetector(
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
                      currentRange =
                          '${formatLocalDateTimeOnlyDateSplashFromDate(dt.start)} - ${formatLocalDateTimeOnlyDateSplashFromDate(dt.end)}';
                      widget.onChagneDateTime(dt);
                    }
                  },
                  child: LoadSvg(assetPath: 'svg/calendar_month.svg'),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (!usingCustomeTime)
                  ...TimeSelector.listTime
                      .map(
                        (e) => UnconstrainedBox(
                          child: GestureDetector(
                            onTap: () => ontap(e),
                            child: TimeHightLight(
                              isSelected: e == currentRange,
                              txt: e,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                if (usingCustomeTime)
                  Row(
                    children: [
                      Text(currentRange),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          currentRange = '';
                          setState(() {});
                        },
                        child: LoadSvg(assetPath: 'svg/close_circle.svg'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeHightLight extends StatelessWidget {
  final bool isSelected;
  final String txt;
  const TimeHightLight({
    super.key,
    required this.isSelected,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: bigRoundBorderRadius,
        color: isSelected ? PurpelColor : TransaprentColor,
      ),
      child: Text(
        txt,
        style: isSelected
            ? headStyleSemiLargeWhite500
            : headStyleSemiLargeSLigh500,
      ),
    );
  }
}

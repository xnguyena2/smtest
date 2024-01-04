import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String host =
    "https://web-production-865f.up.railway.app"; // 'http://192.168.1.212:5001'; //

const String Seperate = '<=>';

const String appVersion = '1.1.0';

String storeName = 'trumbien store';
String groupID = 'trumbien_store';
String deviceID = 'admintestting';
String userPhoneNumber = '0987654321';
bool haveInteret = false;

void changeInterNetStatus(bool status) {
  print('change status: $status');
  haveInteret = status;
}

void setGlobalValue(
    {required String store_ame,
    required String groupId,
    required String phoneNumber,
    required String device_id}) {
  storeName = store_ame;
  groupID = groupId;
  userPhoneNumber = phoneNumber;
  deviceID = device_id;
}

//formater
final MoneyFormater =
    NumberFormat("#,##0", "en_US"); // .simpleCurrency(locale: 'vi_VN'); //

// color
const Color BackgroundColor = Color(0xFFF5F5F5);
const Color BackgroundColorLigh = Color(0xFFFEFEFE);
const Color BackgroundRed = Color(0xFFFFF2F2);
const Color BackgroundHigh = Color(0x1926B074);
const Color White = Colors.white;
const Color White70 = Color.fromARGB(178, 255, 255, 255);
const Color Black = Colors.black;
const Color Red = Colors.red;
const Color Black70 = Color.fromARGB(178, 0, 0, 0);
const Color Black40 = Color.fromARGB(80, 0, 0, 0);
const Color Black15 = Color.fromARGB(38, 0, 0, 0);
const Color HighColor = Color(0xFF0080A9);
const Color HighColor15 = Color(0x260080A9);
const Color MainHighColor = Color(0xFF0080A9);
const Color TableHighColor = Color(0xFF26B074);
const Color TableHighBGColor = Color(0xFF239A66);
const Color TableHeaderBGColor = Color(0xFFE4E4E4);
const Color borderColor = Color.fromARGB(102, 0, 0, 0);
const Color borderColorLight = Color.fromARGB(25, 0, 0, 0);
const Color ShowdownColor = Color.fromARGB(56, 0, 0, 0);
const Color ShowdownColor25 = Color.fromARGB(64, 0, 0, 0);
const Color AlertColor = Color(0xFFC20202);
const Color SelectTableBackgroundColor = Color(0x1980A91A);

const Color RevenueColor = Color.fromARGB(255, 0, 37, 204);
const Color ProfitColor = Color(0xFF239A66);
const Color CostColor = Color.fromARGB(255, 204, 0, 0);

const Color textNormalLightColor = Color(0xFF323232);
const Color textSubLightColor = Color(0xFF404040);

const Color searchBorderColor = Color(0xFFD7D7D7);
const Color searchBackgroundColor = Color(0xFFF3F3F3);

final BorderRadius defaultBorderRadius = BorderRadius.circular(8);

final BorderRadius defaultSquareBorderRadius = BorderRadius.circular(5);

final BorderRadius floatBottomBorderRadius = BorderRadius.circular(24);

final Border defaultBorder = Border.all(color: searchBorderColor);

final Border lightBorder = Border.all(color: Black40);

final Border normalBorder = Border.all(color: Black);

final Border mainHighBorder = Border.all(color: MainHighColor);

final Border tableHighBorder = Border.all(color: TableHighColor);

final Border categoryBorder = Border.all(color: Color(0xFFB8B8B8));

final Border alertBorder = Border.all(color: AlertColor);

const BoxShadow defaultShadow = BoxShadow(
  color: borderColorLight,
  blurRadius: 2,
  offset: Offset(0, 2),
);

const BoxShadow wholeShadow = BoxShadow(
  color: ShowdownColor,
  blurRadius: 4,
  offset: Offset(0, 0),
  spreadRadius: 0,
);

const BoxShadow highShadow = BoxShadow(
  color: TableHighColor,
  blurRadius: 4,
  offset: Offset(0, 0),
  spreadRadius: 0,
);

const TextStyle moneyStyleSuperLarge = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
);

const TextStyle moneyStyleSuperLargeHigh = TextStyle(
  color: TableHighColor,
  fontSize: 30,
  fontWeight: FontWeight.w600,
);

const TextStyle totalMoneyStylexXXLargeWhite = TextStyle(
  color: White,
  fontSize: 26,
  fontWeight: FontWeight.w600,
);

const TextStyle totalMoneyStylexXXLarge = TextStyle(
  color: Red,
  fontSize: 26,
  fontWeight: FontWeight.w500,
);

const TextStyle totalMoneyStylexxXLarge = TextStyle(
  color: White,
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const TextStyle totalMoneyStylexXLarge = TextStyle(
  color: Red,
  fontSize: 21,
  fontWeight: FontWeight.w500,
);

const TextStyle totalMoneyStylexXLargeBlack = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.w500,
);

const TextStyle totalMoneyHeaderStylexXLargeRed = TextStyle(
  color: Red,
  fontSize: 19,
  fontWeight: FontWeight.w600,
);

const TextStyle totalMoneyHeaderStylexXLargeHigh = TextStyle(
  color: TableHighColor,
  fontSize: 19,
  fontWeight: FontWeight.w600,
);

const TextStyle totalMoneyHeaderStylexXLarge = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleXXLarge = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleXLargeSemiBoldHigh = TextStyle(
  color: HighColor,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleXLargeSemiBoldRevenue = TextStyle(
  color: RevenueColor,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleXLargeSemiBoldProfit = TextStyle(
  color: ProfitColor,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleXLargeSemiBoldRed = TextStyle(
  color: Red,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleXLargeSemiBoldCost = TextStyle(
  color: CostColor,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleXLargeSemiBold = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleXLargeLigh = TextStyle(
  color: textSubLightColor,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleXLarge = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleXLargehightUnderline = TextStyle(
  decoration: TextDecoration.underline,
  decorationStyle: TextDecorationStyle.dashed,
  decorationColor: TableHighColor,
  height: 2,
  color: TableHighColor,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleXLargeHigh = TextStyle(
  color: HighColor,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleXLargeHighTable = TextStyle(
  color: TableHighColor,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleXLarge400 = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400,
);

const TextStyle customerNameBigWhite600 = TextStyle(
  color: White,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const TextStyle customerNameBigHigh600 = TextStyle(
  color: TableHighColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const TextStyle customerNameBigRed600 = TextStyle(
  color: Red,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const TextStyle customerNameBig = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle customerNameBigLigh = TextStyle(
  color: Black70,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle customerNameBigHight = TextStyle(
  color: TableHighColor,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle customerNameBigLight400 = TextStyle(
  color: Black40,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle customerNameBigHardLight400 = TextStyle(
  color: Black70,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle customerNameBig400 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleSemiLarge = TextStyle(
  fontSize: 15,
);

const TextStyle headStyleSemiLarge500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

const TextStyle headStyleSemiLargeLigh500 = TextStyle(
  color: Black70,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

const TextStyle headStyleSemiLargeHigh500 = TextStyle(
  color: TableHighColor,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

const TextStyle headStyleSemiLargeAlert500 = TextStyle(
  color: Red,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

const TextStyle headStyleSemiLargeVeryLigh500 = TextStyle(
  color: Black40,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

const TextStyle headStyleSemiLarge400 = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 15,
);

const TextStyle headStyleSemiLargeLight400 = TextStyle(
  color: textNormalLightColor,
  fontWeight: FontWeight.w400,
  fontSize: 15,
);

const TextStyle headStyleSemiLargeHigh400 = TextStyle(
  color: TableHighColor,
  fontWeight: FontWeight.w400,
  fontSize: 15,
);
const TextStyle headStyleSemiLargeLigh400 = TextStyle(
  color: Black70,
  fontWeight: FontWeight.w400,
  fontSize: 15,
);

const TextStyle headStyleLarge = TextStyle(
  fontSize: 14,
);

const TextStyle headStyleLargeAlert = TextStyle(
  color: Red,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleBigMediumBlackLight = TextStyle(
  color: Black70,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleBigMedium = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleBigMediumWhite = TextStyle(
  color: White,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleBigMediumHigh = TextStyle(
  color: TableHighColor,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleSmallLarge = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleLargeRed = TextStyle(
  color: Red,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleLargeWhiteLigh = TextStyle(
  color: White70,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleLargeWhite = TextStyle(
  color: White,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleLargeHigh = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleMedium600 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

const TextStyle headStyleMediumAlert500 = TextStyle(
  color: AlertColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleMediumHigh500 = TextStyle(
  color: TableHighColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleMediumWhite500 = TextStyle(
  color: White,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleMediumWhiteLigh500 = TextStyle(
  color: White70,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleMedium500 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleMedium = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleMediumHigh = TextStyle(
  color: HighColor,
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleMediumNormalLight = TextStyle(
  color: textNormalLightColor,
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

const TextStyle subStyleMediumNormalLight = TextStyle(
  color: textSubLightColor,
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

const TextStyle headStyleMediumNormaWhite = TextStyle(
  color: White,
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyLarge600High = TextStyle(
  color: TableHighColor,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStyLargeAlert600 = TextStyle(
  color: Red,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStyLarge600 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStyLarge500High = TextStyle(
  color: TableHighColor,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle subInfoStyLargeLight500 = TextStyle(
  color: Black70,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle subInfoStyLarge500 = TextStyle(
  color: Black,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle subInfoStyLarge400 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyLargeLigh400 = TextStyle(
  color: Black70,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyLargeHigh400 = TextStyle(
  color: HighColor,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyLargeTable400 = TextStyle(
  color: TableHighBGColor,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyLargeWhite400 = TextStyle(
  color: White,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyLargeRed400 = TextStyle(
  color: Red,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyWhiteMedium = TextStyle(
  color: White,
  fontSize: 11,
  fontWeight: FontWeight.w300,
);

const TextStyle subInfoStyBlackMedium = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w300,
);

const TextStyle subInfoStyMedium400 = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMediumHigh400 = TextStyle(
  color: TableHighColor,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMediumAlert400 = TextStyle(
  color: AlertColor,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMediumWhite400 = TextStyle(
  color: White,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMedium400Light = TextStyle(
  color: Black70,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMedium500 = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w500,
);

const TextStyle subInfoStyMedium600 = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStySmall = TextStyle(
  fontSize: 9,
);

import 'package:flutter/material.dart';

// color
const Color BackgroundColor = Color(0xFFF5F5F5);
const Color White = Colors.white;
const Color Black = Colors.black;
const Color Black70 = Color.fromARGB(178, 0, 0, 0);
const Color HighColor = Color(0xFF0080A9);
const Color MainHighColor = Color(0xFF0080A9);
const Color borderColor = Color.fromARGB(102, 0, 0, 0);
const Color borderColorLight = Color.fromARGB(25, 0, 0, 0);
const Color ShowdownColor = Color.fromARGB(56, 0, 0, 0);
const Color ShowdownColor25 = Color.fromARGB(64, 0, 0, 0);

const Color textNormalLightColor = Color(0xFF323232);

const Color searchBorderColor = Color(0xFFD7D7D7);
const Color searchBackgroundColor = Color(0xFFF3F3F3);

final BorderRadius defaultBorderRadius = BorderRadius.circular(8);

final BorderRadius defaultSquareBorderRadius = BorderRadius.circular(5);

final Border defaultBorder = Border.all(color: searchBorderColor);

final Border normalBorder = Border.all(color: Black);

final Border mainHighBorder = Border.all(color: HighColor);

final Border categoryBorder = Border.all(color: Color(0xFFB8B8B8));

const BoxShadow defaultShadow = BoxShadow(
  color: borderColorLight,
  blurRadius: 2,
  offset: Offset(0, 2),
);

const TextStyle headStyleXLarge = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const TextStyle headStyleSemiLarge = TextStyle(
  fontSize: 15,
);

const TextStyle headStyleLarge = TextStyle(
  fontSize: 14,
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

const TextStyle headStyleMedium600 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStyLarge600High = TextStyle(
  color: Color(0xFF26B074),
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStyLarge600 = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStyLarge500 = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle subInfoStyLarge400 = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyLargeHigh400 = TextStyle(
  color: HighColor,
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
  color: Colors.black,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMedium400Light = TextStyle(
  color: Black70,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMedium500 = TextStyle(
  color: Colors.black,
  fontSize: 11,
  fontWeight: FontWeight.w500,
);

const TextStyle subInfoStyMediumHight400 = TextStyle(
  color: Color(0xFF45C816),
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

const TextStyle subInfoStyMedium600 = TextStyle(
  color: Colors.black,
  fontSize: 11,
  fontWeight: FontWeight.w600,
);

const TextStyle subInfoStySmall = TextStyle(
  fontSize: 9,
);

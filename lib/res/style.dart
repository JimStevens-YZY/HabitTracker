/// theme/app_size.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// 标题文字大小
const double kTitleTextSize = 24;
// 内容体文字大小
const double kBodyTextSize = 14;
// 按钮文字大小
const double kBtnTextSize = 16;
// 按钮圆角半径
const double kBtnRadius = 24;
// 输入框边框圆角半径
const double kInputBorderRadius = 5;
// icon 大小
const double kIconSize = 24;
// icon 盒子大小
const double kIconBoxSize = 56;
// Light 字重
const FontWeight kLightFontWeight = FontWeight.w300;
// Medium 字重
const FontWeight kMediumFontWeight = FontWeight.w500;

/// theme/app_colors.dart

// 背景颜色
const Color kBgColor = Color(0xFFFEDCE0);
// 文字颜色
const Color kTextColor = Color(0xFF3D0007);
// 按钮开始颜色
const Color kBtnColorStart = Color.fromRGBO(116, 235, 213, 1.0);
// 按钮结束颜色
const Color kBtnColorEnd =Color.fromRGBO(172, 182, 229, 1.0);
// 按钮投影颜色
const Color kBtnShadowColor = Color.fromRGBO(232, 216, 218, 1.0);
// 输入框边框颜色
const Color kInputBorderColor = Color(0xFFECECEC);

// 按钮渐变背景色
const LinearGradient kBtnLinearGradient = LinearGradient(
  colors: [
    kBtnColorStart,
    kBtnColorEnd,
  ],
);



// 按钮投影
const List<BoxShadow> kBtnShadow = [
  BoxShadow(
    color: kBtnShadowColor,
    offset: Offset(0, 8),
    blurRadius: 20,
  )
];

// 按钮文字样式
const TextStyle kBtnTextStyle = TextStyle(
  color: Color.fromRGBO(136, 203, 213, 1.0),
  fontSize: kBtnTextSize,
  fontWeight: kMediumFontWeight,
);

// 标题文字样式
const TextStyle kTitleTextStyle = TextStyle(
  fontSize: kTitleTextSize,
  color: kTextColor,
  fontWeight: kMediumFontWeight,
);

// 内容文字样式
const TextStyle kBodyTextStyle = TextStyle(
  fontSize: kBodyTextSize,
  color: kTextColor,
  fontWeight: kLightFontWeight,
);

// 输入框边框
OutlineInputBorder kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(
    color: kInputBorderColor,
    width: 1,
  ),
);


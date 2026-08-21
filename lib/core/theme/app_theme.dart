import 'package:flutter/material.dart';

import '../const/app_const.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: fontFamily,
  colorScheme: ColorScheme.light(
    primary: Color(0xffC66B44), //#944521 #F5F2F0
    secondary: Color(0xffFCF9F8), //#F5F2F0 F5F0E1 #FCF9F8
    surface: Color(0xffFCF9F8), //#FCF9F8 FFEDE7
    onSurface: Color(0xff2D2D2D),
  ),
);

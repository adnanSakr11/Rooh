import 'package:flutter/material.dart';

ThemeData appTheme=ThemeData(
  useMaterial3: true,
    brightness: Brightness.light,
    //fontFamily: AppConfig.fontFamily,
colorScheme: ColorScheme.light(
  primary: Color(0xffC66B44), 
  secondary: Color(0xffF5F0E1), 
  surface: Color(0xffFFEDE7),
  onSurface: Color(0xff2D2D2D),
));
// class AppTheme {
//   AppTheme._();
//   static ThemeData get light => ThemeData(
//     useMaterial3: true,
//         brightness: Brightness.light,
//         //fontFamily: AppConfig.fontFamily,
//     colorScheme: ColorScheme.light(
//       primary: Color(0xffC66B44), 
//       secondary: Color(0xffF5F0E1), 
//       surface: Color(0xffFFEDE7),
//       onSurface: Color(0xff2D2D2D),
//       ),
//   );
// }

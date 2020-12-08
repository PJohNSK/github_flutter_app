import 'package:flutter/material.dart';

class AppStyle {

  // THEME
  static final ThemeData clientTheme = ThemeData(

    primaryColor: AppColor.white,
    primaryColorDark: AppColor.primaryDark,
    accentColor: AppColor.accent,
    dividerColor: AppColor.divider,
    backgroundColor: AppColor.background,
    buttonColor: AppColor.controlColor,
    secondaryHeaderColor: AppColor.secondary,

    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    applyElevationOverlayColor: true,
    indicatorColor: AppColor.white,

    textTheme: _appClientTextTheme,

    fontFamily: 'ProductSans',
    scaffoldBackgroundColor: AppColor.background,
    bottomAppBarColor: AppColor.black,
    appBarTheme: AppBarTheme(color: AppColor.primary,
        elevation: 0,
        textTheme: TextTheme(title: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryDark, fontSize: 18,)),
        iconTheme: IconThemeData(color: AppColor.textColor)
    ),

    bottomAppBarTheme: BottomAppBarTheme(color: AppColor.black, elevation: 0,),

  );

  static final List<BoxShadow> cardShadow = [
    BoxShadow(color: AppColor.shadowColor, blurRadius: 5),
  ];

  static final List<BoxShadow> mildCardShadow = [
    BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 1),
  ];

  static TextTheme get _appClientTextTheme {
    return TextTheme(
      title: AppTextStyle.text,
      subtitle: AppTextStyle.subHeader,
      headline: AppTextStyle.text,
      button: AppTextStyle.button,
      display1: AppTextStyle.normal,
      display2: AppTextStyle.mainHeader,
      subhead: AppTextStyle.subHeader,
      body1: AppTextStyle.body,
      body2: AppTextStyle.normal,
    );
  }

  static Widget divider = Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.divider, width: 0.1),
    ),
  );

}



class AppTextStyle {

  static TextStyle get text {
    return TextStyle(color: AppColor.black, fontSize: 16,);
  }

  static TextStyle get body {
    return TextStyle(color: AppColor.subHeader, fontSize: 18,);
  }

  static TextStyle get normal {
    return TextStyle(color: AppColor.secondary, fontSize: 14, height: 1.5,);
  }

  static TextStyle get underline {
    return TextStyle(color: AppColor.secondary, decoration: TextDecoration.underline, fontSize: 14, height: 1.5,);
  }

  static TextStyle get button {
    return TextStyle(color: AppColor.black, fontSize: 14, height: 1.5,);
  }

  static TextStyle get subHeader {
    return TextStyle(color: AppColor.white, fontSize: 24,);
  }

  static TextStyle get mainHeader {
    return TextStyle(color: AppColor.secondary, fontSize: 24, fontWeight: FontWeight.bold);
  }

  static TextStyle get logoblue {
    return TextStyle(color: AppColor.logoBlue, fontSize: 24, fontWeight: FontWeight.normal);
  }

  static TextStyle get logogrey {
    return TextStyle(color: AppColor.logogrey, fontSize: 24, fontWeight: FontWeight.normal);
  }

  static TextStyle get caption {
    return TextStyle(color: AppColor.subTextColor, fontSize: 14,);
  }

}

class AppColor {

  static final Color white = Color(0xFFFFFFFF);
  static final Color primary = Color(0xFFFFFFFF);
  static final Color primaryDark = Color(0xFF03A9F4);
  static final Color secondary = Color(0xFF03A9F4);
  static final Color controlColor = Color(0xFF03A9F4);
  static final Color progress = Color(0xFF03A9F4);

  static final Color black =  Color(0xFF000000);
  static final Color subHeader = Color(0xFF525252);
  static final Color cardBackground = Color(0xFFFFFFFF);
  static final Color cardSelectedBackground = Color(0xFF000000);
  static final Color disable = Color(0xFFEBEBE4);

  static final Color background = Color(0xFFFFFFFF);
  static final Color appBarBackground = Color(0xFFFFFFFF);

  static final Color alternateBackground = Color(0xFFF7F7F7);
  static final Color accent = Color(0xFF000000);
  static final Color divider = Color(0xFF707070);
  static final Color subTextColor  = Color(0xFF707070);
  static final Color textColor  = Color(0xFF000000);

  static final Color logoBlue  = Color(0xFF007bbe);
  static final Color logogrey  = Color(0xFF5f5c58);
  static const Color shadowColor = Color(0xFFE3E3E3);
}

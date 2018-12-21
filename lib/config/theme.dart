import 'package:flutter/material.dart';
final ThemeData SpreadLight = ThemeData(
  backgroundColor: Color(0xfff1f1f1),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xfff1f1f1),
  secondaryHeaderColor: Color(0xffd2d2d2),
  primarySwatch: Colors.blue,
  primaryColor: Color(0xfff1f1f1),
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.blue[400],
  primaryTextTheme: TextTheme(title: TextStyle(color:Colors.black87.withOpacity(0.9),fontFamily: 'MontSerrat')),
  accentColorBrightness: Brightness.light,
  splashColor: Colors.blue,
  iconTheme: IconThemeData(color: Colors.black87),
  textSelectionColor: Colors.blue,
  dividerColor: Colors.grey,
  unselectedWidgetColor: Colors.black87,
  buttonColor: Colors.black87,
  canvasColor: Colors.white70.withOpacity(0.9),
);
final ThemeData SpreadDark = ThemeData(
  backgroundColor: Color(0xff202121),
  scaffoldBackgroundColor: Color(0xff202121),
  secondaryHeaderColor: Colors.black54.withOpacity(0.9),
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  primaryColor: Color(0xff202121),
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.blue,
  accentColorBrightness: Brightness.dark,
  splashColor: Colors.blue[300],
  primaryTextTheme: TextTheme(title: TextStyle(color:Color(0xfff1f1f1).withOpacity(0.1),fontFamily: 'MontSerrat')),
  iconTheme: IconThemeData(color: Colors.grey),
  textSelectionColor: Colors.blue,
  unselectedWidgetColor: Colors.grey,
  dividerColor: Colors.grey[700],
  buttonColor: Colors.grey,
  canvasColor: Color(0xff202121).withOpacity(0.9),
);
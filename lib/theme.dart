import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  hintColor: Colors.white,
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  primaryColorBrightness: Brightness.light,
  accentColorBrightness: Brightness.light,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  textTheme: TextTheme(
      body1: TextStyle(color: Colors.white),
      title: TextStyle(color: Colors.white),
      ),
);

final lightTheme = ThemeData(
  hintColor: Colors.white,
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.dark,
  accentColorBrightness: Brightness.dark,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  textTheme: TextTheme(
      body1: TextStyle(color: Colors.black),
      title: TextStyle(color: Colors.black)),
);
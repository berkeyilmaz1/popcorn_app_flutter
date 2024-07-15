import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
        fontFamily: "Raleway",
        iconTheme: const IconThemeData(color: Colors.white),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                foregroundColor: WidgetStatePropertyAll(Colors.white))),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.blue,
            onPrimary: Colors.white,
            secondary: Colors.lightBlue,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white));
  }
}

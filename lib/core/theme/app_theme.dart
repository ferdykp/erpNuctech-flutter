import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
    ),
  );
}

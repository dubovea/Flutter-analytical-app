import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Avenir',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        displayMedium: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        displaySmall: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headlineMedium: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        headlineSmall: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        titleLarge: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      ));
}

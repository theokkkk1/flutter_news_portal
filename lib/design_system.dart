import 'package:flutter/material.dart';

class DesignSystem {
  static const Color primary = Color(0xFF1E88E5);

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  // -------------------------------
  // TEMA CLARO
  // -------------------------------
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    
    // brightness e colorScheme CONSISTENTES
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: const Color(0xFFF7F9FC),

    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),

    cardTheme: const CardThemeData(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
    ),
  );

  // -------------------------------
  // TEMA ESCURO
  // -------------------------------
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),

    cardTheme: const CardThemeData(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Color(0xFF1E1E1E),
    ),
  );
}

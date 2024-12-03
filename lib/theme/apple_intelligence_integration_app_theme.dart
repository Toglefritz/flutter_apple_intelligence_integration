import 'package:flutter/material.dart';

/// Provides [ThemeData] for the Apple Intelligence Integration Demo app.
class AppleIntelligenceIntegrationAppTheme {
  /// Returns dark theme data for the Apple Intelligence Integration Demo app.
  static ThemeData themeData = ThemeData(
    primaryColor: Colors.black,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white54,
    useMaterial3: true,
    fontFamily: 'Chicago',
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
        ),
        borderRadius: BorderRadius.zero,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
        ),
        borderRadius: BorderRadius.zero,
      ),
      filled: true,
      fillColor: Colors.black12,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.black26,
      selectionHandleColor: Colors.black,
    ),
  );
}

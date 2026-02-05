import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeistTheme {
  // Money Heist palette
  static const Color crimson = Color(0xFFB71C1C);
  static const Color scarlet = Color(0xFFD32F2F);
  static const Color ink = Color(0xFF0A0A0A);
  static const Color gunmetal = Color(0xFF1A1A1A);
  static const Color iron = Color(0xFF2A2A2A);
  static const Color gold = Color(0xFFC9A227);
  static const Color smoke = Color(0xFF9E9E9E);

  static ThemeData theme() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: scarlet,
        brightness: Brightness.dark,
        primary: scarlet,
        secondary: gold,
        surface: gunmetal,
      ),
      scaffoldBackgroundColor: ink,
      textTheme: _textTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: gunmetal,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0x22FFFFFF)),
        ),
      ),
      dividerColor: iron,
    );
  }

  static TextTheme _textTheme(TextTheme base) {
    final heading = GoogleFonts.cinzel(
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
    );
    final body = GoogleFonts.montserrat();

    return base.copyWith(
      displayLarge: heading.copyWith(fontSize: 48, color: Colors.white),
      displayMedium: heading.copyWith(fontSize: 36, color: Colors.white),
      displaySmall: heading.copyWith(fontSize: 28, color: Colors.white),
      headlineMedium: heading.copyWith(fontSize: 22, color: Colors.white),
      titleLarge: heading.copyWith(fontSize: 20, color: Colors.white),
      titleMedium: body.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      titleSmall: body.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: body.copyWith(fontSize: 16, color: Colors.white70),
      bodyMedium: body.copyWith(fontSize: 14, color: Colors.white70),
      labelLarge: body.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  static BoxShadow glow({Color color = scarlet}) => BoxShadow(
    color: color.withValues(alpha: 0.4),
    blurRadius: 24,
    spreadRadius: 1,
    offset: const Offset(0, 6),
  );
}

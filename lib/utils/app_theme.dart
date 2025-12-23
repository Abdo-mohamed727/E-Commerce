import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Appcolors.primary,
      secondary: Appcolors.blue,
      error: Appcolors.red,
      background: Appcolors.white,
      surface: Appcolors.white,
      onBackground: Appcolors.black,
      onSurface: Appcolors.black,
      onPrimary: Appcolors.white,
      onSecondary: Appcolors.white,
    ),
    scaffoldBackgroundColor: Appcolors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Appcolors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Appcolors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Appcolors.black),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Appcolors.black),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black54),
      titleLarge: TextStyle(
        color: Appcolors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: Colors.black87),
      titleSmall: TextStyle(color: Colors.black54),
      labelLarge: TextStyle(color: Appcolors.black),
      labelMedium: TextStyle(color: Colors.black87),
      labelSmall: TextStyle(color: Colors.black54),
    ),
    iconTheme: IconThemeData(color: Appcolors.black),
    dividerColor: Appcolors.grey2,
    cardColor: Appcolors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolors.primary,
        foregroundColor: Appcolors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Appcolors.grey2,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Appcolors.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Appcolors.red, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Appcolors.primary,
      contentTextStyle: TextStyle(color: Appcolors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Appcolors.white,
      selectedItemColor: Appcolors.primary,
      unselectedItemColor: Appcolors.grey,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Appcolors.primary,
      secondary: Appcolors.blue,
      error: Appcolors.red,
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
      onBackground: Appcolors.white,
      onSurface: Appcolors.white,
      onPrimary: Appcolors.white,
      onSecondary: Appcolors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Appcolors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Appcolors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Appcolors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white60),
      titleLarge: TextStyle(
        color: Appcolors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: Colors.white70),
      titleSmall: TextStyle(color: Colors.white60),
      labelLarge: TextStyle(color: Appcolors.white),
      labelMedium: TextStyle(color: Colors.white70),
      labelSmall: TextStyle(color: Colors.white60),
    ),
    iconTheme: IconThemeData(color: Appcolors.white),
    dividerColor: Colors.grey[800],
    cardColor: Color(0xFF1E1E1E),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolors.primary,
        foregroundColor: Appcolors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Appcolors.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Appcolors.red, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Appcolors.primary,
      contentTextStyle: TextStyle(color: Appcolors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Appcolors.primary,
      unselectedItemColor: Appcolors.grey,
    ),
  );
}

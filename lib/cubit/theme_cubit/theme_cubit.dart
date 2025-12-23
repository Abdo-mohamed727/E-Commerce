import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

enum ThemeModeState { light, dark, system }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial()) {
    _loadTheme();
  }

  static const String _themePreferenceKey = 'theme_mode';

  /// Load saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString(_themePreferenceKey);

      if (themeModeString != null) {
        final themeMode = ThemeModeState.values.firstWhere(
          (e) => e.name == themeModeString,
          orElse: () => ThemeModeState.system,
        );
        _emitThemeMode(themeMode);
      } else {
        // Default to system theme if no preference saved
        emit(const ThemeModeChanges(ThemeMode.system));
      }
    } catch (e) {
      // If loading fails, default to system theme
      emit(const ThemeModeChanges(ThemeMode.system));
    }
  }

  /// Save theme to SharedPreferences
  Future<void> _saveTheme(ThemeModeState theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themePreferenceKey, theme.name);
    } catch (e) {
      // Handle save error silently
      debugPrint('Error saving theme preference: $e');
    }
  }

  /// Select and apply theme
  Future<void> selectTheme(ThemeModeState theme) async {
    _emitThemeMode(theme);
    await _saveTheme(theme);
  }

  /// Helper method to emit theme mode
  void _emitThemeMode(ThemeModeState theme) {
    switch (theme) {
      case ThemeModeState.light:
        emit(const ThemeModeChanges(ThemeMode.light));
        break;
      case ThemeModeState.dark:
        emit(const ThemeModeChanges(ThemeMode.dark));
        break;
      case ThemeModeState.system:
        emit(const ThemeModeChanges(ThemeMode.system));
        break;
    }
  }

  /// Get current theme mode state
  ThemeModeState get currentThemeMode {
    final currentState = state;
    if (currentState is ThemeModeChanges) {
      switch (currentState.themeMode) {
        case ThemeMode.light:
          return ThemeModeState.light;
        case ThemeMode.dark:
          return ThemeModeState.dark;
        case ThemeMode.system:
          return ThemeModeState.system;
      }
    }
    return ThemeModeState.system;
  }
}

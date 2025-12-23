part of 'theme_cubit.dart';

abstract class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(ThemeMode.system);
}

class ThemeModeChanges extends ThemeState {
  const ThemeModeChanges(ThemeMode themeMode) : super(themeMode);
}

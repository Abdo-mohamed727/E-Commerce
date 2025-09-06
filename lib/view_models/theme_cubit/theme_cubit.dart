import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

enum ThemeModeState { light, dark, system }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void selectTheme(ThemeModeState theme) {
    switch (theme) {
      case ThemeModeState.light:
        emit(ThemeModeChanges(ThemeMode.light));
        break;
      case ThemeModeState.dark:
        emit(ThemeModeChanges(ThemeMode.dark));
        break;
      case ThemeModeState.system:
        emit(ThemeModeChanges(ThemeMode.system));
        break;
    }
  }
}

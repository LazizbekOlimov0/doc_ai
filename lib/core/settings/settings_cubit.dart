import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../gen/strings.g.dart';

class SettingsState {
  final ThemeMode themeMode;
  final AppLocale locale;

  const SettingsState({
    this.themeMode = ThemeMode.light,
    this.locale = AppLocale.uz,
  });

  bool get isDark => themeMode == ThemeMode.dark;

  SettingsState copyWith({ThemeMode? themeMode, AppLocale? locale}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  static const _themeKey = 'theme_mode';
  static const _localeKey = 'app_locale';

  SettingsCubit() : super(const SettingsState()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeStr = prefs.getString(_themeKey) ?? 'light';
      final localeStr = prefs.getString(_localeKey) ?? 'uz';

      final themeMode =
          themeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
      final locale = AppLocale.values.firstWhere(
        (l) => l.languageCode == localeStr,
        orElse: () => AppLocale.uz,
      );

      LocaleSettings.setLocale(locale);
      emit(SettingsState(themeMode: themeMode, locale: locale));
    } catch (_) {
      emit(const SettingsState());
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state.isDark ? ThemeMode.light : ThemeMode.dark;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _themeKey, newMode == ThemeMode.dark ? 'dark' : 'light');
    } catch (_) {}
    emit(state.copyWith(themeMode: newMode));
  }

  Future<void> setLocale(AppLocale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (_) {}
    LocaleSettings.setLocale(locale);
    emit(state.copyWith(locale: locale));
  }
}

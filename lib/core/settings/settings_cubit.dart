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

  final SharedPreferences _prefs;

  SettingsCubit(this._prefs) : super(const SettingsState()) {
    _load();
  }

  Future<SettingsState> loadInitial() async {
    final themeStr = _prefs.getString(_themeKey) ?? 'light';
    final localeStr = _prefs.getString(_localeKey) ?? 'uz';

    final themeMode = themeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
    final locale = AppLocale.values.firstWhere(
      (l) => l.languageCode == localeStr,
      orElse: () => AppLocale.uz,
    );
    return SettingsState(themeMode: themeMode, locale: locale);
  }

  void _load() {
    final themeStr = _prefs.getString(_themeKey) ?? 'light';
    final localeStr = _prefs.getString(_localeKey) ?? 'uz';

    final themeMode = themeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
    final locale = AppLocale.values.firstWhere(
      (l) => l.languageCode == localeStr,
      orElse: () => AppLocale.uz,
    );

    LocaleSettings.setLocale(locale);
    emit(SettingsState(themeMode: themeMode, locale: locale));
  }

  Future<void> toggleTheme() async {
    final newMode = state.isDark ? ThemeMode.light : ThemeMode.dark;
    await _prefs.setString(
        _themeKey, newMode == ThemeMode.dark ? 'dark' : 'light');
    emit(state.copyWith(themeMode: newMode));
  }

  Future<void> setLocale(AppLocale locale) async {
    await _prefs.setString(_localeKey, locale.languageCode);
    LocaleSettings.setLocale(locale);
    emit(state.copyWith(locale: locale));
  }
}

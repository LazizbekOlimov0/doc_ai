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

  late final SharedPreferences? _prefs;
  final Map<String, dynamic> _memory = {};

  SettingsCubit({SharedPreferences? prefs}) : super(const SettingsState()) {
    _prefs = prefs;
    _load();
  }

  void _load() {
    final themeStr = _read(_themeKey) ?? 'light';
    final localeStr = _read(_localeKey) ?? 'uz';

    final themeMode = themeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
    final locale = AppLocale.values.firstWhere(
      (l) => l.languageCode == localeStr,
      orElse: () => AppLocale.uz,
    );

    LocaleSettings.setLocale(locale);
    emit(SettingsState(themeMode: themeMode, locale: locale));
  }

  String? _read(String key) {
    final fromPrefs = _prefs?.getString(key);
    if (fromPrefs != null) return fromPrefs;
    return _memory[key] as String?;
  }

  Future<void> _save(String key, String value) async {
    _memory[key] = value;
    _prefs?.setString(key, value);
  }

  Future<void> toggleTheme() async {
    final newMode = state.isDark ? ThemeMode.light : ThemeMode.dark;
    await _save(_themeKey, newMode == ThemeMode.dark ? 'dark' : 'light');
    emit(state.copyWith(themeMode: newMode));
  }

  Future<void> setLocale(AppLocale locale) async {
    await _save(_localeKey, locale.languageCode);
    LocaleSettings.setLocale(locale);
    emit(state.copyWith(locale: locale));
  }
}

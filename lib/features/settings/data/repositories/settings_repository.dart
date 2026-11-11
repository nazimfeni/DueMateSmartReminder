import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------
// Keys
// ---------------------------------------------------------------------------
abstract final class _Keys {
  static const themeMode = 'theme_mode';
  static const locale = 'locale';
  static const defaultCurrency = 'default_currency';
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
    (_) => SharedPreferences.getInstance());

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).valueOrNull;
  return ThemeModeNotifier(prefs);
});

final appLocaleProvider =
    StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).valueOrNull;
  return LocaleNotifier(prefs);
});

final defaultCurrencyProvider =
    StateNotifierProvider<DefaultCurrencyNotifier, String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).valueOrNull;
  return DefaultCurrencyNotifier(prefs);
});

// ---------------------------------------------------------------------------
// Notifiers
// ---------------------------------------------------------------------------

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._prefs) : super(_load(_prefs));

  final SharedPreferences? _prefs;

  static ThemeMode _load(SharedPreferences? prefs) {
    final stored = prefs?.getString(_Keys.themeMode);
    return ThemeMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await _prefs?.setString(_Keys.themeMode, mode.name);
  }
}

class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier(this._prefs) : super(_load(_prefs));

  final SharedPreferences? _prefs;

  static Locale? _load(SharedPreferences? prefs) {
    final stored = prefs?.getString(_Keys.locale);
    if (stored == null) return null;
    return Locale(stored);
  }

  Future<void> set(Locale? locale) async {
    state = locale;
    if (locale == null) {
      await _prefs?.remove(_Keys.locale);
    } else {
      await _prefs?.setString(_Keys.locale, locale.languageCode);
    }
  }
}

class DefaultCurrencyNotifier extends StateNotifier<String> {
  DefaultCurrencyNotifier(this._prefs) : super(_load(_prefs));

  final SharedPreferences? _prefs;

  static String _load(SharedPreferences? prefs) =>
      prefs?.getString(_Keys.defaultCurrency) ?? 'BDT';

  Future<void> set(String currency) async {
    state = currency;
    await _prefs?.setString(_Keys.defaultCurrency, currency);
  }
}

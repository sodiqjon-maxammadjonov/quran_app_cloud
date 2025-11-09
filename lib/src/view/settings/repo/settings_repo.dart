import '../../../data/library/library.dart';

abstract class SettingsRepo {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);

  Brightness getSystemBrightness();
  Stream<ThemeMode> watchThemeMode();
  void dispose();
}

class SettingsRepoImpl implements SettingsRepo {
  final Emitter<SettingsState> emit;

  static const String _themeModeKey = 'theme_mode';
  late final SharedPreferences _prefs;
  final _themeModeController = StreamController<ThemeMode>.broadcast();
  bool _initialized = false;

  SettingsRepoImpl(this.emit);

  Future<void> _init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    try {
      await _init();
      final String? savedMode = _prefs.getString(_themeModeKey);

      ThemeMode themeMode;
      if (savedMode == null) {
        themeMode = ThemeMode.system;
      } else {
        themeMode = ThemeMode.values.firstWhere(
              (mode) => mode.name == savedMode,
          orElse: () => ThemeMode.system,
        );
      }

      // Emit qilish
      final theme = _getThemeData(themeMode);
      emit(SettingsThemeState(
        theme: theme,
        themeMode: themeMode,
      ));

      return themeMode;
    } catch (e) {
      print('Error loading theme: $e');
      // Xatolik bo'lsa, default tema
      final theme = _getThemeData(ThemeMode.system);
      emit(SettingsThemeState(
        theme: theme,
        themeMode: ThemeMode.system,
      ));
      return ThemeMode.system;
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      await _init();
      await _prefs.setString(_themeModeKey, mode.name);
      _themeModeController.add(mode);

      // Emit qilish
      final theme = _getThemeData(mode);
      emit(SettingsThemeState(
        theme: theme,
        themeMode: mode,
      ));
    } catch (e) {
      print('Error saving theme: $e');
      // Xatolik bo'lsa ham UI ni yangilash
      final theme = _getThemeData(mode);
      emit(SettingsThemeState(
        theme: theme,
        themeMode: mode,
      ));
    }
  }

  @override
  Brightness getSystemBrightness() {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  @override
  Stream<ThemeMode> watchThemeMode() {
    return _themeModeController.stream;
  }

  CupertinoThemeData _getThemeData(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppTheme.lightTheme;
      case ThemeMode.dark:
        return AppTheme.darkTheme;
      case ThemeMode.system:
        final brightness = getSystemBrightness();
        return brightness == Brightness.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme;
    }
  }

  @override
  void dispose() {
    _themeModeController.close();
  }
}
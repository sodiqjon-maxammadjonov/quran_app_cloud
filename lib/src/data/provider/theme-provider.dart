import '/src/data/library/library.dart';

enum ThemeMode { light, dark, system }

class ThemeProvider extends ChangeNotifier with WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system;
  CupertinoThemeData _theme = AppTheme.darkTheme;

  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
    _updateTheme();
  }

  ThemeMode get themeMode => _themeMode;
  CupertinoThemeData get theme => _theme;

  @override
  void didChangePlatformBrightness() {
    if (_themeMode == ThemeMode.system) {
      _updateTheme();
    }
    super.didChangePlatformBrightness();
  }

  void setLight() {
    _themeMode = ThemeMode.light;
    _updateTheme();
  }

  void setDark() {
    _themeMode = ThemeMode.dark;
    _updateTheme();
  }

  void setSystem() {
    _themeMode = ThemeMode.system;
    _updateTheme();
  }

  void _updateTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _theme = AppTheme.lightTheme;
        break;
      case ThemeMode.dark:
        _theme = AppTheme.darkTheme;
        break;
      case ThemeMode.system:
        final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
        _theme = brightness == Brightness.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme;
        break;
    }
    notifyListeners();
  }

  String getCurrentThemeLabel() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Yorug\'';
      case ThemeMode.dark:
        return 'Tungi';
      case ThemeMode.system:
        return 'Sistema';
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
part of 'settings_bloc.dart';

enum ThemeMode {
  light,
  dark,
  system
}

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsThemeState extends SettingsState {
  final CupertinoThemeData theme;
  final ThemeMode themeMode;

  SettingsThemeState({
    required this.theme,
    required this.themeMode,
  });
}
part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class LoadSettings extends SettingsEvent {
  final ThemeMode themeMode;
  LoadSettings({required this.themeMode});
}

class SetLightTheme extends SettingsEvent {}

class SetDarkTheme extends SettingsEvent {}

class SetSystemTheme extends SettingsEvent {}

class SystemBrightnessChanged extends SettingsEvent {}
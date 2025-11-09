import '../../../data/library/library.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(loadSettings);
    on<SetLightTheme>(setLightTheme);
    on<SetDarkTheme>(setDarkTheme);
    on<SetSystemTheme>(setSystemTheme);
    on<SystemBrightnessChanged>(systemBrightnessChanged);
  }

  FutureOr<void> loadSettings(
      LoadSettings event,
      Emitter<SettingsState> emit,
      ) async {
    await SettingsRepoImpl(emit).getThemeMode();
  }

  FutureOr<void> setLightTheme(
      SetLightTheme event,
      Emitter<SettingsState> emit,
      ) async {
    await SettingsRepoImpl(emit).setThemeMode(ThemeMode.light);
  }

  FutureOr<void> setDarkTheme(
      SetDarkTheme event,
      Emitter<SettingsState> emit,
      ) async {
    await SettingsRepoImpl(emit).setThemeMode(ThemeMode.dark);
  }

  FutureOr<void> setSystemTheme(
      SetSystemTheme event,
      Emitter<SettingsState> emit,
      ) async {
    await SettingsRepoImpl(emit).setThemeMode(ThemeMode.system);
  }

  FutureOr<void> systemBrightnessChanged(
      SystemBrightnessChanged event,
      Emitter<SettingsState> emit,
      ) async {
    if (state is SettingsThemeState) {
      final currentState = state as SettingsThemeState;

      if (currentState.themeMode == ThemeMode.system) {
        final repo = SettingsRepoImpl(emit);
        final brightness = repo.getSystemBrightness();

        if (brightness == Brightness.dark) {
          AppTheme.setCurrentTheme(AppTheme.darkTheme);
        } else {
          AppTheme.setCurrentTheme(AppTheme.lightTheme);
        }

        emit(SettingsThemeState(
          theme: AppTheme.currentTheme,
          themeMode: ThemeMode.system,
        ));
      }
    }
  }
}
import '/src/data/library/library.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) {
        if (previous is SettingsThemeState &&
            current is SettingsThemeState) {
          return previous.themeMode != current.themeMode;
        }
        return true;
      },
      builder: (context, settingsState) {
        final theme = (settingsState is SettingsThemeState)
            ? settingsState.theme
            : AppTheme.currentTheme;

        return BlocBuilder<NavBarBloc, NavBarState>(
          builder: (context, navState) {
            return CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                backgroundColor: theme.barBackgroundColor,
                activeColor: theme.primaryColor,
                inactiveColor: CupertinoColors.inactiveGray,
                currentIndex: navState.id,
                height: 60,
                onTap: (index) {
                  context.read<NavBarBloc>().add(
                    NavbarChangeEvent(id: index),
                  );
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: t?.home,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.book),
                    label: t?.quron,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.clock),
                    label: t?.namozTimes,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.check_mark_circled),
                    label: t?.tasbeh,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings_solid),
                    label: t?.settings,
                  ),
                ],
              ),
              tabBuilder: (context, index) {
                Widget page;
                switch (index) {
                  case 0:
                    page = const Home();
                    break;
                  case 1:
                    page = const Quron();
                    break;
                  case 2:
                    page = const Namoz();
                    break;
                  case 3:
                    page = const Tasbeh();
                    break;
                  case 4:
                    page = const Settings();
                    break;
                  default:
                    page = const Home();
                }
                return CupertinoTabView(builder: (context) => page);
              },
            );
          },
        );
      },
    );
  }
}
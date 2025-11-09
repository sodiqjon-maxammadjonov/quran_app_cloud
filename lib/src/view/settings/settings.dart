import 'package:quran_app_cloud/src/data/library/library.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void _showThemePicker(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    BottomSheetPicker.show(
      context: context,
      title: t.appearance,
      options: [
        PickerOption(
          label: t.light,
          emoji: '☀️',
          onTap: () {
            context.read<SettingsBloc>().add(SetLightTheme());
          },
        ),
        PickerOption(
          label: t.dark,
          emoji: '🌙',
          onTap: () {
            context.read<SettingsBloc>().add(SetDarkTheme());
          },
        ),
        PickerOption(
          label: t.system,
          emoji: '📱',
          onTap: () {
            context.read<SettingsBloc>().add(SetSystemTheme());
          }
        ),
      ],
    );
  }

  void _showLanguagePicker(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    BottomSheetPicker.show(
      context: context,
      title: t.language,
      options: [
        PickerOption(
          label: t.uzbek,
          emoji: '🇺🇿',
          onTap: () {
            // TODO: O'zbek tiliga o'tkazish
          },
        ),
        PickerOption(
          label: t.english,
          emoji: '🇬🇧',
          onTap: () {
            // TODO: Ingliz tiliga o'tkazish
          },
        ),
        PickerOption(
          label: t.arabic,
          emoji: '🇸🇦',
          onTap: () {
            // TODO: Arab tiliga o'tkazish
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final t = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      navigationBar: AppBarWidget(
        title: t.settings,
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            _buildSectionHeader(context, t.appearance),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.moon_stars_fill,
                  iconColor: CupertinoColors.systemIndigo,
                  title: t.theme,
                  subtitle: t.system,
                  trailing: CupertinoIcons.chevron_right,
                  onTap: () => _showThemePicker(context),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, t.language),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.globe,
                  iconColor: CupertinoColors.systemBlue,
                  title: t.appLanguage,
                  subtitle: t.uzbek,
                  trailing: CupertinoIcons.chevron_right,
                  onTap: () => _showLanguagePicker(context),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, t.notifications),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.bell_fill,
                  iconColor: CupertinoColors.systemRed,
                  title: t.namozTimes,
                  subtitle: t.on,
                  onTap: () {
                    // TODO: Namoz bildirishnomalar settings
                  },
                ),
                SettingsTile(
                  icon: CupertinoIcons.book_fill,
                  iconColor: CupertinoColors.systemGreen,
                  title: t.dailyReminder,
                  subtitle: t.off,
                  showDivider: false,
                  onTap: () {
                    // TODO: Kundalik eslatma settings
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, t.aboutApp),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.info_circle_fill,
                  iconColor: CupertinoColors.systemGrey,
                  title: t.version,
                  subtitle: '1.0.0',
                  onTap: () {
                    // TODO: About page
                  },
                ),
                SettingsTile(
                  icon: CupertinoIcons.star_fill,
                  iconColor: CupertinoColors.systemYellow,
                  title: t.rateApp,
                  subtitle: t.appStore,
                  showDivider: false,
                  onTap: () {
                    // TODO: Rate app
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = CupertinoTheme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: MyText(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: theme.primaryColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<Widget> children) {
    final theme = CupertinoTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.barBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isDark ? CupertinoColors.black : CupertinoColors.systemGrey)
                .withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

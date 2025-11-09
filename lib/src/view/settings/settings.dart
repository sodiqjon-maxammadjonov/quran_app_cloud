import 'package:quran_app_cloud/src/data/library/library.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void _showLanguagePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: MyText(
          'Tilni tanlang',
          style: TextStyle(
            fontSize: 13,
            color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.6),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // TODO: O'zbek tiliga o'tkazish
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText('🇺🇿  O\'zbekcha'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Ingliz tiliga o'tkazish
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText('🇬🇧  English'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Arab tiliga o'tkazish
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText('🇸🇦  العربية'),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDestructiveAction: true,
          child: MyText('Bekor qilish'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final t = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      navigationBar: AppBarWidget(
        title: t!.settings,
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            // Theme Section
            _buildSectionHeader(context, 'Ko\'rinish'),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.moon_stars_fill,
                  iconColor: CupertinoColors.systemIndigo,
                  title: 'Tungi rejim',
                  subtitle: 'Dark mode',
                  onTap: () {
                    // TODO: Theme o'zgartirish
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Language Section
            _buildSectionHeader(context, 'Til'),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.globe,
                  iconColor: CupertinoColors.systemBlue,
                  title: 'Ilova tili',
                  subtitle: 'O\'zbekcha',
                  trailing: CupertinoIcons.chevron_right,
                  onTap: () => _showLanguagePicker(context),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Notifications Section
            _buildSectionHeader(context, 'Bildirishnomalar'),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.bell_fill,
                  iconColor: CupertinoColors.systemRed,
                  title: 'Namoz vaqtlari',
                  subtitle: 'Yoqilgan',
                  onTap: () {
                    // TODO: Namoz bildirishnomalar settings
                  },
                ),
                SettingsTile(
                  icon: CupertinoIcons.book_fill,
                  iconColor: CupertinoColors.systemGreen,
                  title: 'Kundalik eslatma',
                  subtitle: 'O\'chirilgan',
                  showDivider: false,
                  onTap: () {
                    // TODO: Kundalik eslatma settings
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            // About Section
            _buildSectionHeader(context, 'Ilova haqida'),
            _buildSettingsGroup(
              context,
              [
                SettingsTile(
                  icon: CupertinoIcons.info_circle_fill,
                  iconColor: CupertinoColors.systemGrey,
                  title: 'Versiya',
                  subtitle: '1.0.0',
                  onTap: () {
                    // TODO: About page
                  },
                ),
                SettingsTile(
                  icon: CupertinoIcons.star_fill,
                  iconColor: CupertinoColors.systemYellow,
                  title: 'Baholang',
                  subtitle: 'App Store\'da',
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
                .withOpacity(isDark ? 0.3 : 0.1),
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
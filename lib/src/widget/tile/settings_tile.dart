import 'package:quran_app_cloud/src/data/library/library.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final IconData? trailing;
  final VoidCallback onTap;
  final bool showDivider;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.textStyle.color,
                        ),
                      ),
                      const SizedBox(height: 2),
                      MyText(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textTheme.textStyle.color?.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  trailing ?? CupertinoIcons.chevron_right,
                  color: theme.textTheme.textStyle.color?.withValues(alpha: 0.3),
                  size: 20,
                ),
              ],
            ),
          ),
        ),

        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Container(
              height: 0.5,
              color: theme.textTheme.textStyle.color?.withValues(alpha: 0.1),
            ),
          ),
      ],
    );
  }
}
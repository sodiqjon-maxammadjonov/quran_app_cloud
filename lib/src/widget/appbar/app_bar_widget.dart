
import 'package:intl/intl.dart';
import 'package:quran_app_cloud/src/data/library/library.dart';

class AppBarWidget extends StatelessWidget implements ObstructingPreferredSizeWidget {
  final String title;
  final Widget? trailing;

  const AppBarWidget({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy.M.d, EE', 'uz_UZ').format(now);

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 16,bottom: 10),
      decoration: BoxDecoration(
        color: theme.barBackgroundColor.withAlpha(240),
        border: Border(
          bottom: BorderSide(
            color: theme.primaryContrastingColor.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title,
                  style: theme.textTheme.navTitleTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                MyText(
                  formattedDate,
                  style: theme.textTheme.dateTimePickerTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: trailing!,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}

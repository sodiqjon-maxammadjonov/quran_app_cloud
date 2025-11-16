import '/src/data/library/library.dart';

class SurahItemCard extends StatelessWidget {
  final SurahModel surah;
  final VoidCallback? onTap;

  const SurahItemCard({
    super.key,
    required this.surah,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final width = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: theme.barBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.barBackgroundColor.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Sol tomon - Raqam
            _buildNumberBadge(theme),

            const SizedBox(width: 12),

            // O'rta - Ma'lumotlar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sura nomi (inglizcha)
                  MyText(
                    surah.nameSimple,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      MyText(
                        _getRevelationText(l10n),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        color: theme.textTheme.textStyle.color?.withValues(alpha: 0.6),
                      ),

                      MyText(
                        ' • ',
                        style: GoogleFonts.inter(fontSize: 13),
                        color: theme.textTheme.textStyle.color?.withValues(alpha: 0.6),
                      ),

                      MyText(
                        '${surah.versesCount} ${l10n.verses}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        color: theme.textTheme.textStyle.color?.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            MyText(
              surah.nameArabic,
              style: AppTheme.arabicTextStyle(
                isDark: theme.brightness == Brightness.dark,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBadge(CupertinoThemeData theme) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: MyText(
          '${surah.id}',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          color: theme.primaryColor,
        ),
      ),
    );
  }

  String _getRevelationText(AppLocalizations l10n) {
    return surah.revelationPlace.toLowerCase() == 'makkah'
        ? l10n.makkan
        : l10n.medinan;
  }
}
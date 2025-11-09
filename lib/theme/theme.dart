import '/src/data/library/library.dart';

class AppTheme {
  // Light Theme
  static CupertinoThemeData lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    primaryContrastingColor: AppColors.lightOnPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    barBackgroundColor: AppColors.lightSurface,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.lightOnSecondary,
      textStyle: GoogleFonts.inter(
        color: AppColors.lightOnSecondary,
        fontSize: 16,
      ),
      actionTextStyle: GoogleFonts.inter(
        color: AppColors.lightPrimary,
        fontWeight: FontWeight.w600,
      ),
      navTitleTextStyle: GoogleFonts.inter(
        color: AppColors.lightOnSecondary,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      navLargeTitleTextStyle: GoogleFonts.inter(
        color: AppColors.lightOnSecondary,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
        dateTimePickerTextStyle: GoogleFonts.inter(
          color: AppColors.lightDivider.withValues(alpha: 0.8),
          fontSize: 13,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
        )
    ),
  );

  // Dark Theme
  static CupertinoThemeData darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    primaryContrastingColor: AppColors.darkOnPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    barBackgroundColor: AppColors.darkSurface,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.darkOnSecondary,
      textStyle: GoogleFonts.inter(
        color: AppColors.darkOnSecondary,
        fontSize: 16,
      ),
      actionTextStyle: GoogleFonts.inter(
        color: AppColors.darkPrimary,
        fontWeight: FontWeight.w600,
      ),
      navTitleTextStyle: GoogleFonts.inter(
        color: AppColors.darkOnSecondary,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      navLargeTitleTextStyle: GoogleFonts.inter(
        color: AppColors.darkOnSecondary,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
        dateTimePickerTextStyle: GoogleFonts.inter(
          color: AppColors.lightPrimary.withValues(alpha: 0.8),
          fontSize: 13,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
        )

    ),
  );

  static CupertinoThemeData get currentTheme => darkTheme;

  static TextStyle arabicTextStyle({
    required bool isDark,
    double fontSize = 28,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.amiri(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      height: 2.0,
      letterSpacing: 0.5,
    );
  }

  static TextStyle arabicScheherazade({
    required bool isDark,
    double fontSize = 28,
  }) {
    return GoogleFonts.scheherazadeNew(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      height: 2.0,
    );
  }

  static TextStyle arabicLateef({
    required bool isDark,
    double fontSize = 28,
  }) {
    return GoogleFonts.lateef(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      height: 2.0,
    );
  }

  static TextStyle quranVerseStyle({
    required bool isDark,
    double fontSize = 26,
  }) {
    return GoogleFonts.amiriQuran(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
      height: 2.2,
      letterSpacing: 0.3,
    );
  }

  // Sura nomi uchun style
  static TextStyle suraNameStyle({
    required bool isDark,
    double fontSize = 32,
  }) {
    return GoogleFonts.amiri(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      height: 1.5,
    );
  }
}
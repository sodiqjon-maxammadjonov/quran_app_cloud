import 'package:flutter/cupertino.dart';

class AppColors {
  // Light Theme - Islamic Inspired Colors
  static const Color lightPrimary = Color(0xFF059669); // Emerald-600
  static const Color lightPrimaryDark = Color(0xFF047857); // Emerald-700
  static const Color lightPrimaryLight = Color(0xFF10B981); // Emerald-500
  static const Color lightSecondaryColor = Color(0xFF14B8A6); // Teal-500
  static const Color lightBackground = Color(0xBEE9FFF3); // Emerald-50 - Asosiy fon (yashil-oq)
  static const Color lightSurface = CupertinoColors.white; // White - Card/BottomNav foni
  static const Color lightOnPrimary = CupertinoColors.white;
  static const Color lightOnSurface = Color(0xFF111827); // Gray-900
  static const Color lightOnBackground = Color(0xFF1F2937); // Gray-800
  static const Color lightSecondary = Color(0xFF6B7280); // Gray-500
  static const Color lightOnSecondary = Color(0xFF111827); // Gray-900
  static const Color lightError = Color(0xFFDC2626); // Red-600
  static const Color lightOnError = CupertinoColors.white;
  static const Color lightDivider = Color(0xFFE5E7EB); // Gray-200
  static const Color lightCardBackground = CupertinoColors.white; // White - Card foni

  static const Color lightGradientStart = Color(0xFF059669); // Emerald-600
  static const Color lightGradientEnd = Color(0xFF14B8A6); // Teal-500
  static const Color lightAccentBlue = Color(0xFF3B82F6); // Blue-500
  static const Color lightAccentPurple = Color(0xFFA855F7); // Purple-500

  // Dark Theme - Islamic Inspired Colors
  static const Color darkPrimary = Color(0xFF10B981); // Emerald-500
  static const Color darkPrimaryDark = Color(0xFF059669); // Emerald-600
  static const Color darkPrimaryLight = Color(0xFF34D399); // Emerald-400
  static const Color darkSecondaryColor = Color(0xFF14B8A6); // Teal-500
  static const Color darkBackground = Color(0xFF030712); // Gray-950 - Asosiy fon (to'q qora)
  static const Color darkSurface = Color(0xFF111827); // Gray-900 - Card/BottomNav foni (ochroq)
  static const Color darkOnPrimary = CupertinoColors.white;
  static const Color darkOnSurface = Color(0xFFF9FAFB); // Gray-50
  static const Color darkOnBackground = Color(0xFFE5E7EB); // Gray-200
  static const Color darkSecondary = Color(0xFF9CA3AF); // Gray-400
  static const Color darkOnSecondary = CupertinoColors.white;
  static const Color darkError = Color(0xFFEF4444); // Red-500
  static const Color darkOnError = CupertinoColors.white;
  static const Color darkDivider = Color(0xFF374151); // Gray-700
  static const Color darkCardBackground = Color(0xFF111827); // Gray-900 - Card foni

  static const Color darkGradientStart = Color(0xFF065F46); // Emerald-800
  static const Color darkGradientEnd = Color(0xFF115E59); // Teal-800
  static const Color darkAccentEmerald = Color(0xFF34D399); // Emerald-400
  static const Color darkAccentTeal = Color(0xFF2DD4BF); // Teal-400

  static const Color quranGold = Color(0xFFD97706); // Amber-600
  static const Color prayerBlue = Color(0xFF3B82F6); // Blue-500
  static const Color tasbehPurple = Color(0xFFA855F7); // Purple-500
  static const Color arabicGreen = Color(0xFF059669); // Emerald-600

  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color info = Color(0xFF3B82F6); // Blue-500

  // Helper method to get gradient colors
  static LinearGradient getLightGradient() {
    return const LinearGradient(
      colors: [lightGradientStart, lightGradientEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient getDarkGradient() {
    return const LinearGradient(
      colors: [darkGradientStart, darkGradientEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient getCardGradient(bool isDark) {
    if (isDark) {
      return const LinearGradient(
        colors: [Color(0xFF065F46), Color(0xFF115E59)], // Emerald-800 to Teal-800
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF14B8A6)], // Emerald-500 to Teal-500
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  static LinearGradient getButtonGradient() {
    return const LinearGradient(
      colors: [Color(0xFF10B981), Color(0xFF14B8A6)], // Emerald-500 to Teal-500
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}
class AyahEditions {
  // English
  static const String en = "en.asad"; // Muhammad Asad

  // Uzbek
  static const String uz = "uz.sodik"; // Muhammad Sodik

  // Russian
  static const String ru = "ru.kuliev"; // Elmir Kuliev

  // Kazakh
  static const String kz = "kk.alim"; // Kazakh Alim Translation

  // Kyrgyz
  static const String ky = "ky.omurbek"; // Kyrgyz Omurbek Translation

  // Turkish
  static const String tr = "tr.ates"; // Turkish Ateş Translation

  // Arabic (Original)
  static const String ar = "quran-uthmani"; // Mushaf Uthmani

  // French
  static const String fr = "fr.hamidullah"; // Muhammad Hamidullah

  // German
  static const String de = "de.ahmedali"; // Ahmed Ali German

  /// Hammasini vergul bilan ajratilgan string qilib qaytaradi
  static String getAll() {
    return [en, uz, ru, kz, ky, tr, ar, fr, de].join(',');
  }
}

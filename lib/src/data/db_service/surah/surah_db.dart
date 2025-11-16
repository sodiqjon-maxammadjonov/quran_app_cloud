import '../../library/library.dart';

class SurahDb {
  static final SurahDb _instance = SurahDb._internal();
  factory SurahDb() => _instance;
  SurahDb._internal();

  late Box<SurahModel> _box;

  Future<void> init() async {
    _box = Hive.box<SurahModel>('surahs');
  }

  /// Bitta surani qo'shish yoki yangilash
  Future<void> upsertSurah(SurahModel surah) async {
    await _box.put(surah.id, surah);
  }

  /// Ko'p suralarni bir vaqtda qo'shish (API dan kelganda)
  Future<void> upsertManySurahs(List<SurahModel> surahs) async {
    final Map<int, SurahModel> surahMap = {
      for (var surah in surahs) surah.id: surah
    };
    await _box.putAll(surahMap);
  }

  /// Surani o'chirish
  Future<void> deleteSurah(int id) async {
    await _box.delete(id);
  }

  /// Barcha suralarni o'chirish
  Future<void> clearAll() async {
    await _box.clear();
  }

  // ==================== O'QISH OPERATSIYALARI ====================

  /// Barcha suralarni olish (tartibda)
  List<SurahModel> getAllSurahs() {
    final surahs = _box.values.toList();
    surahs.sort((a, b) => a.id.compareTo(b.id));
    return surahs;
  }

  /// ID bo'yicha sura olish
  SurahModel? getSurahById(int id) {
    return _box.get(id);
  }

  /// Sura mavjudligini tekshirish
  bool hasSurah(int id) {
    return _box.containsKey(id);
  }

  /// Database bo'shligini tekshirish
  bool get isEmpty => _box.isEmpty;

  /// Suralar sonini olish
  int get count => _box.length;

  // ==================== QIDIRUV VA FILTRLASH ====================

  /// Nom bo'yicha qidirish (arab, ingliz yoki translitatsiya)
  List<SurahModel> searchByName(String query) {
    if (query.trim().isEmpty) return getAllSurahs();

    final lowerQuery = query.toLowerCase();
    return _box.values.where((surah) {
      return surah.nameSimple.toLowerCase().contains(lowerQuery) ||
          surah.nameComplex.toLowerCase().contains(lowerQuery) ||
          surah.nameArabic.contains(query) ||
          surah.translatedName.name.toLowerCase().contains(lowerQuery);
    }).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  /// Makkiy suralarni olish
  List<SurahModel> getMakkanSurahs() {
    return _box.values
        .where((surah) => surah.revelationPlace.toLowerCase() == 'makkah')
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  /// Madaniy suralarni olish
  List<SurahModel> getMadaniSurahs() {
    return _box.values
        .where((surah) => surah.revelationPlace.toLowerCase() == 'madinah')
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  /// Nozil bo'lish tartibi bo'yicha suralar
  List<SurahModel> getSurahsByRevelationOrder() {
    final surahs = _box.values.toList();
    surahs.sort((a, b) => a.revelationOrder.compareTo(b.revelationOrder));
    return surahs;
  }

  /// Oyatlar soni bo'yicha filtrlash
  List<SurahModel> getSurahsByVersesRange(int minVerses, int maxVerses) {
    return _box.values
        .where((surah) =>
    surah.versesCount >= minVerses && surah.versesCount <= maxVerses)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  /// Juz (sahifa) bo'yicha suralarni topish
  List<SurahModel> getSurahsByPage(int pageNumber) {
    return _box.values
        .where((surah) => surah.pages.contains(pageNumber))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  // ==================== STATISTIKA ====================

  /// Umumiy oyatlar sonini hisoblash
  int getTotalVerses() {
    return _box.values.fold(0, (sum, surah) => sum + surah.versesCount);
  }

  /// Eng uzun surani topish
  SurahModel? getLongestSurah() {
    if (_box.isEmpty) return null;
    return _box.values.reduce(
            (a, b) => a.versesCount > b.versesCount ? a : b);
  }

  /// Eng qisqa surani topish
  SurahModel? getShortestSurah() {
    if (_box.isEmpty) return null;
    return _box.values.reduce(
            (a, b) => a.versesCount < b.versesCount ? a : b);
  }

  /// Makkiy suralar sonini olish
  int getMakkanCount() {
    return _box.values
        .where((s) => s.revelationPlace.toLowerCase() == 'makkah')
        .length;
  }

  /// Madaniy suralar sonini olish
  int getMadaniCount() {
    return _box.values
        .where((s) => s.revelationPlace.toLowerCase() == 'madinah')
        .length;
  }

  // ==================== NAVIGATSIYA ====================

  /// Keyingi surani olish
  SurahModel? getNextSurah(int currentId) {
    if (currentId >= 114) return null;
    return _box.get(currentId + 1);
  }

  /// Oldingi surani olish
  SurahModel? getPreviousSurah(int currentId) {
    if (currentId <= 1) return null;
    return _box.get(currentId - 1);
  }

  // ==================== YORDAMCHI METODLAR ====================

  /// Birinchi marta ma'lumotlarni yuklash kerakmi?
  bool get needsInitialData => _box.isEmpty;

  /// Ma'lumotlar to'liqligini tekshirish (114 ta sura bo'lishi kerak)
  bool get isDataComplete => _box.length == 114;

  /// Stream - real-time yangilanishlar uchun
  Stream<BoxEvent> watchSurahs() {
    return _box.watch();
  }

  /// Ma'lum surani kuzatish
  Stream<BoxEvent> watchSurah(int id) {
    return _box.watch(key: id);
  }
}
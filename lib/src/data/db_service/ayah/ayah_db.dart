import '../../library/library.dart';

class AyahDb {
  static final AyahDb _instance = AyahDb._internal();
  factory AyahDb() => _instance;
  AyahDb._internal();

  late Box<AyahModel> _box;

  Future<void> init() async {
    _box = Hive.box<AyahModel>('ayahs');
  }

  Future<void> upsertManyAyahs(List<AyahModel> ayahs) async {
    final Map<int, AyahModel> ayahMap = {
      for (var ayah in ayahs) ayah.id: ayah
    };
    await _box.putAll(ayahMap);
  }

  Future<void> deleteAyahsBySurah(int surahId) async {
    final keysToDelete = _box.values
        .where((ayah) => ayah.surahId == surahId)
        .map((ayah) => ayah.id)
        .toList();

    for (var key in keysToDelete) {
      await _box.delete(key);
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  List<AyahModel> getAyahsBySurah(int surahId) {
    final ayahs = _box.values
        .where((ayah) => ayah.surahId == surahId)
        .toList();
    ayahs.sort((a, b) => a.ayahNumber.compareTo(b.ayahNumber));
    return ayahs;
  }

  bool hasSurahAyahs(int surahId) {
    return _box.values.any((ayah) => ayah.surahId == surahId);
  }

  int get count => _box.length;
  bool get isEmpty => _box.isEmpty;
}

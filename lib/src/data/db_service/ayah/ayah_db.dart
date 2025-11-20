import '../../library/library.dart';

class AyahDb {
  static const String boxName = 'ayahs_box';
  late Box<AyahModel> _box;

  /// Hive box'ni ochish
  Future<void> init() async {
    _box = await Hive.openBox<AyahModel>(boxName);
  }

  /// Oyatlarni Hive'ga saqlash
  Future<void> saveAyahs(List<AyahModel> ayahs) async {
    try {
      for (var ayah in ayahs) {
        await _box.put(ayah.id, ayah);
      }
      print('${ayahs.length} ta oyat saqlandi');
    } catch (e) {
      print('AyahDb Save Error: $e');
      rethrow;
    }
  }

  /// Surah va tili boyicha oyatlarni olish
  Future<List<AyahModel>> getAyahsBySurahAndEdition(
      int surahId,
      String editionId,
      ) async {
    try {
      final prefix = '${surahId}_${editionId}_';
      List<AyahModel> ayahs = [];

      for (var key in _box.keys) {
        if (key.toString().startsWith(prefix)) {
          ayahs.add(_box.get(key)!);
        }
      }

      // Oyat raqami boyicha sort qilish
      ayahs.sort((a, b) => a.number.compareTo(b.number));

      return ayahs;
    } catch (e) {
      print('AyahDb Get Error: $e');
      return [];
    }
  }

  /// Faqat sura boyicha barcha oyatlarni olish (barcha tillar)
  Future<List<AyahModel>> getAyahsBySurah(int surahId) async {
    try {
      final prefix = '${surahId}_';
      List<AyahModel> ayahs = [];

      for (var key in _box.keys) {
        if (key.toString().startsWith(prefix)) {
          ayahs.add(_box.get(key)!);
        }
      }

      ayahs.sort((a, b) => a.number.compareTo(b.number));
      return ayahs;
    } catch (e) {
      print('AyahDb Get Surah Error: $e');
      return [];
    }
  }

  /// Surah va tili boyicha bitta oyatni olish
  Future<AyahModel?> getAyah(
      int surahId,
      String editionId,
      int ayahNumber,
      ) async {
    try {
      final key = '${surahId}_${editionId}_$ayahNumber';
      return _box.get(key);
    } catch (e) {
      print('AyahDb Get Single Error: $e');
      return null;
    }
  }

  /// Barcha tillarni olish (surah'ga oid)
  Future<Map<String, List<AyahModel>>> getAllEditionsForSurah(
      int surahId,
      ) async {
    try {
      final prefix = '${surahId}_';
      Map<String, List<AyahModel>> languages = {};

      for (var key in _box.keys) {
        if (key.toString().startsWith(prefix)) {
          var ayah = _box.get(key)!;
          String editionId = ayah.edition.identifier;

          if (!languages.containsKey(editionId)) {
            languages[editionId] = [];
          }
          languages[editionId]!.add(ayah);
        }
      }

      // Har bir editionni sort qilish
      languages.forEach((key, value) {
        value.sort((a, b) => a.number.compareTo(b.number));
      });

      return languages;
    } catch (e) {
      print('AyahDb Get All Editions Error: $e');
      return {};
    }
  }

  /// Oyatni qidirish (text boyicha)
  Future<List<AyahModel>> searchAyahs(String query) async {
    try {
      List<AyahModel> results = [];

      for (var ayah in _box.values) {
        if (ayah.text.toLowerCase().contains(query.toLowerCase())) {
          results.add(ayah);
        }
      }

      return results;
    } catch (e) {
      print('AyahDb Search Error: $e');
      return [];
    }
  }

  /// Hive'ni tozalash
  Future<void> clear() async {
    try {
      await _box.clear();
      print('Hive cleared');
    } catch (e) {
      print('AyahDb Clear Error: $e');
    }
  }

  /// Box'ni yopish
  Future<void> closeBox() async {
    try {
      await _box.close();
    } catch (e) {
      print('AyahDb Close Error: $e');
    }
  }
}

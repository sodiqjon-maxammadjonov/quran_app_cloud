
import '../../library/library.dart';

class AyahRepository {
  final AyahDb _db = AyahDb();
  final ApiService _api = ApiService();
  final Emitter<AyahState> emit;

  AyahRepository(this.emit);

  Future<void> loadAyahsBySurah(int surahId) async {
    emit(const AyahLoading());

    try {
      // DB da bor ekanini tekshir
      if (_db.hasSurahAyahs(surahId)) {
        final ayahs = _db.getAyahsBySurah(surahId);
        emit(AyahsLoaded(ayahs));
        return;
      }

      // API dan yuklash
      final ayahs = await _api.fetchAyahsBySurah(surahId);

      if (ayahs.isNotEmpty) {
        await _db.upsertManyAyahs(ayahs);
        emit(AyahsLoaded(ayahs));
      } else {
        emit(const AyahEmpty('Oyatlar topilmadi'));
      }
    } catch (e) {
      emit(AyahError(e.toString()));
    }
  }

  Future<void> preloadFirstSurah() async {
    try {
      if (!_db.hasSurahAyahs(1)) {
        await loadAyahsBySurah(1);
      }
    } catch (e) {
      print('Preload xatosi: $e');
    }
  }
}
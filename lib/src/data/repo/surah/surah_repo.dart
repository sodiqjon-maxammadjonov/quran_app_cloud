import '../../library/library.dart';


class SurahRepository {
  final SurahDb _db = SurahDb();
  final ApiService _api = ApiService();
  final Emitter<SurahState> emit;

  SurahRepository(this.emit);

  /// Barcha suralarni yuklash
  Future<void> loadAllSurahs() async {

    emit(const SurahLoading());
    try {
      if (_db.isEmpty) {
        await _loadFromApi();
      }

      final surahs = _db.getAllSurahs();

      if (surahs.isEmpty) {
        emit(const SurahEmpty('No surahs found'));
      } else {
        emit(SurahsLoaded(surahs));
      }
    } catch (e) {
      emit(SurahError(e.toString()));
    }
  }

  /// Qidiruv
  Future<void> searchSurahs(String query) async {
    emit(const SurahLoading());

    try {
      if (_db.isEmpty) {
        await _loadFromApi();
      }

      final surahs = _filterBySearch(_db.getAllSurahs(), query);

      if (surahs.isEmpty) {
        emit(const SurahEmpty('No results found'));
      } else {
        emit(SurahsLoaded(surahs));
      }
    } catch (e) {
      emit(SurahError(e.toString()));
    }
  }

  /// Filtrlar bilan yuklash
  Future<void> filterSurahs({
    String? revelationPlace,
    int? minVerses,
    int? maxVerses,
    int? pageNumber,
    bool sortByRevelation = false,
  }) async {
    emit(const SurahLoading());

    try {
      if (_db.isEmpty) {
        await _loadFromApi();
      }

      List<SurahModel> surahs = _db.getAllSurahs();

      // Filtrlarni qo'lla
      if (revelationPlace != null) {
        surahs = _filterByRevelation(surahs, revelationPlace);
      }

      if (minVerses != null || maxVerses != null) {
        surahs = _filterByVerses(surahs, minVerses, maxVerses);
      }

      if (pageNumber != null) {
        surahs = _filterByPage(surahs, pageNumber);
      }

      if (sortByRevelation) {
        surahs.sort((a, b) => a.revelationOrder.compareTo(b.revelationOrder));
      }

      if (surahs.isEmpty) {
        emit(const SurahEmpty('No surahs match the filters'));
      } else {
        emit(SurahsLoaded(surahs));
      }
    } catch (e) {
      emit(SurahError(e.toString()));
    }
  }

  /// Bitta surani ID bo'yicha yuklash
  Future<void> loadSurahById(int id) async {
    emit(const SurahLoading());

    try {
      if (_db.isEmpty) {
        await _loadFromApi();
      }

      final surah = _db.getSurahById(id);

      if (surah == null) {
        emit(SurahEmpty('Surah with ID $id not found'));
      } else {
        emit(SurahLoaded(surah));
      }
    } catch (e) {
      emit(SurahError(e.toString()));
    }
  }

  /// Ma'lumotlarni yangilash (refresh)
  Future<void> refreshSurahs() async {
    emit(const SurahLoading());

    try {
      await _db.clearAll();
      await _loadFromApi();

      final surahs = _db.getAllSurahs();

      if (surahs.isEmpty) {
        emit(const SurahEmpty('No surahs found after refresh'));
      } else {
        emit(SurahsLoaded(surahs));
      }
    } catch (e) {
      emit(SurahError(e.toString()));
    }
  }


  /// API dan suralarni yuklash va DB ga saqlash
  Future<void> _loadFromApi() async {
    try {
      final response = await _api.fetchSurahs();
      final List<SurahModel> surahs = (response['chapters'] as List)
          .map((json) => SurahModel.fromJson(json))
          .toList();

      await _db.upsertManySurahs(surahs);
    } catch (e) {
      throw Exception('API dan yuklashda xatolik: $e');
    }
  }

  /// Qidiruv filtri - raqam, nom, arab nom bo'yicha
  List<SurahModel> _filterBySearch(List<SurahModel> surahs, String query) {
    final lowerQuery = query.toLowerCase().trim();

    final surahNumber = int.tryParse(query);
    if (surahNumber != null) {
      return surahs.where((surah) => surah.id == surahNumber).toList();
    }

    return surahs.where((surah) {
      return surah.nameSimple.toLowerCase().contains(lowerQuery) ||
          surah.nameComplex.toLowerCase().contains(lowerQuery) ||
          surah.nameArabic.contains(query) ||
          surah.translatedName.name.toLowerCase().contains(lowerQuery) ||
          surah.id.toString().contains(query);
    }).toList();
  }

  /// Makkiy/Madaniy filtri
  List<SurahModel> _filterByRevelation(
      List<SurahModel> surahs, String place) {
    return surahs
        .where((s) => s.revelationPlace.toLowerCase() == place.toLowerCase())
        .toList();
  }

  /// Oyatlar soni filtri
  List<SurahModel> _filterByVerses(
      List<SurahModel> surahs, int? min, int? max) {
    return surahs.where((surah) {
      if (min != null && surah.versesCount < min) return false;
      if (max != null && surah.versesCount > max) return false;
      return true;
    }).toList();
  }

  /// Sahifa bo'yicha filtri
  List<SurahModel> _filterByPage(List<SurahModel> surahs, int page) {
    return surahs.where((s) => s.pages.contains(page)).toList();
  }
}

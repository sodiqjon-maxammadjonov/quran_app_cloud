import '../../../data/library/library.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(const SurahInitial()) {
    on<LoadAllSurahs>(_onLoadAllSurahs);
    on<SearchSurahs>(_onSearchSurahs);
    on<FilterSurahs>(_onFilterSurahs);
    on<LoadSurahById>(_onLoadSurahById);
    on<RefreshSurahs>(_onRefreshSurahs);
  }

  /// Barcha suralarni yuklash
  Future<void> _onLoadAllSurahs(
      LoadAllSurahs event,
      Emitter<SurahState> emit,
      ) async {
    await SurahRepository(emit).loadAllSurahs();
  }

  /// Qidiruv
  Future<void> _onSearchSurahs(
      SearchSurahs event,
      Emitter<SurahState> emit,
      ) async {
    await SurahRepository(emit).searchSurahs(event.query);
  }

  /// Filtrlar bilan yuklash
  Future<void> _onFilterSurahs(
      FilterSurahs event,
      Emitter<SurahState> emit,
      ) async {
    await SurahRepository(emit).filterSurahs(
      revelationPlace: event.revelationPlace,
      minVerses: event.minVerses,
      maxVerses: event.maxVerses,
      pageNumber: event.pageNumber,
      sortByRevelation: event.sortByRevelation,
    );
  }

  /// Bitta surani yuklash
  Future<void> _onLoadSurahById(
      LoadSurahById event,
      Emitter<SurahState> emit,
      ) async {
    await SurahRepository(emit).loadSurahById(event.id);
  }

  /// Ma'lumotlarni yangilash
  Future<void> _onRefreshSurahs(
      RefreshSurahs event,
      Emitter<SurahState> emit,
      ) async {
    await SurahRepository(emit).refreshSurahs();
  }
}

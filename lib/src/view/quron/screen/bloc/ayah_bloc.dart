
import '../../../../data/library/library.dart';

part 'ayah_event.dart';
part 'ayah_state.dart';

class AyahBloc extends Bloc<AyahEvent, AyahState> {
  AyahBloc() : super(const AyahInitial()) {
    on<LoadAyahsBySurah>(_onLoadAyahsBySurah);
    on<PreloadFirstSurah>(_onPreloadFirstSurah);
  }

  Future<void> _onLoadAyahsBySurah(
      LoadAyahsBySurah event,
      Emitter<AyahState> emit,
      ) async {
    await AyahRepository(emit).loadAyahsBySurah(event.surahId);
  }

  Future<void> _onPreloadFirstSurah(
      PreloadFirstSurah event,
      Emitter<AyahState> emit,
      ) async {
    await AyahRepository(emit).preloadFirstSurah();
  }
}
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_app_cloud/src/data/library/library.dart';

part 'ayah_event.dart';
part 'ayah_state.dart';

class AyahBloc extends Bloc<AyahEvent, AyahState> {
  AyahBloc() : super(AyahInitial()) {
    on<LoadAyahs>(loadAyahs);
  }

  Future loadAyahs(
      LoadAyahs event,
      Emitter<AyahState> emit,
      ) async {
    await AyahRepoImpl(emit).getAyahs(event.surahId, event.editions);
  }
}

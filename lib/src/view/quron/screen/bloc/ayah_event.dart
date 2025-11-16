part of 'ayah_bloc.dart';

@immutable
abstract class AyahEvent {
  const AyahEvent();
}

class LoadAyahsBySurah extends AyahEvent {
  final int surahId;
  const LoadAyahsBySurah(this.surahId);
}

class PreloadFirstSurah extends AyahEvent {
  const PreloadFirstSurah();
}

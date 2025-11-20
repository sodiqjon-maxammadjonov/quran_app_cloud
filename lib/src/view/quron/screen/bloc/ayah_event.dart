part of 'ayah_bloc.dart';

@immutable
sealed class AyahEvent {}

class LoadAyahs extends AyahEvent {
  final int surahId;
  final String editions;
  LoadAyahs(this.surahId, this.editions);
}
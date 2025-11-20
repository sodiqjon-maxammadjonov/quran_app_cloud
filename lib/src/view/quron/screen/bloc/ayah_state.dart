part of 'ayah_bloc.dart';

@immutable
sealed class AyahState {}

final class AyahInitial extends AyahState {}

final class AyahLoading extends AyahState {}

final class AyahError extends AyahState {
  final String message;
  AyahError(this.message);
}

class AyahLoadedState extends AyahState {
  final Map<String, List<AyahModel>> ayah;
  AyahLoadedState(this.ayah);
}
part of 'ayah_bloc.dart';

@immutable
abstract class AyahState {
  const AyahState();
}

class AyahInitial extends AyahState {
  const AyahInitial();
}

class AyahLoading extends AyahState {
  const AyahLoading();
}

class AyahsLoaded extends AyahState {
  final List<AyahModel> ayahs;
  const AyahsLoaded(this.ayahs);
}

class AyahEmpty extends AyahState {
  final String message;
  const AyahEmpty(this.message);
}

class AyahError extends AyahState {
  final String message;
  const AyahError(this.message);
}
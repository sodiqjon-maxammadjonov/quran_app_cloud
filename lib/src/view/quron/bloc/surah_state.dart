part of 'surah_bloc.dart';

@immutable
abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object?> get props => [];
}

class SurahInitial extends SurahState {
  const SurahInitial();
}

class SurahLoading extends SurahState {
  const SurahLoading();
}

class SurahsLoaded extends SurahState {
  final List<SurahModel> surahs;

  const SurahsLoaded(this.surahs);

  @override
  List<Object?> get props => [surahs];
}

class SurahLoaded extends SurahState {
  final SurahModel surah;

  const SurahLoaded(this.surah);

  @override
  List<Object?> get props => [surah];
}

class SurahEmpty extends SurahState {
  final String message;

  const SurahEmpty(this.message);

  @override
  List<Object?> get props => [message];
}

class SurahError extends SurahState {
  final String message;

  const SurahError(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'surah_bloc.dart';

@immutable
abstract class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllSurahs extends SurahEvent {
  const LoadAllSurahs();
}

class SearchSurahs extends SurahEvent {
  final String query;

  const SearchSurahs(this.query);

  @override
  List<Object?> get props => [query];
}
class FilterSurahs extends SurahEvent {
  final String? revelationPlace;
  final int? minVerses;
  final int? maxVerses;
  final int? pageNumber;
  final bool sortByRevelation;

  const FilterSurahs({
    this.revelationPlace,
    this.minVerses,
    this.maxVerses,
    this.pageNumber,
    this.sortByRevelation = false,
  });

  @override
  List<Object?> get props => [
    revelationPlace,
    minVerses,
    maxVerses,
    pageNumber,
    sortByRevelation,
  ];
}

class LoadSurahById extends SurahEvent {
  final int id;

  const LoadSurahById(this.id);

  @override
  List<Object?> get props => [id];
}

class RefreshSurahs extends SurahEvent {
  const RefreshSurahs();
}
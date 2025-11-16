import 'package:quran_app_cloud/src/data/library/library.dart';

part 'surah_model.g.dart';

@HiveType(typeId: 0)
class SurahModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String revelationPlace;

  @HiveField(2)
  final int revelationOrder;

  @HiveField(3)
  final bool bismillahPre;

  @HiveField(4)
  final String nameSimple;

  @HiveField(5)
  final String nameComplex;

  @HiveField(6)
  final String nameArabic;

  @HiveField(7)
  final int versesCount;

  @HiveField(8)
  final List<int> pages;

  @HiveField(9)
  final TranslatedName translatedName;

  SurahModel({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.translatedName,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      id: json['id'] as int,
      revelationPlace: json['revelation_place'] as String,
      revelationOrder: json['revelation_order'] as int,
      bismillahPre: json['bismillah_pre'] as bool,
      nameSimple: json['name_simple'] as String,
      nameComplex: json['name_complex'] as String,
      nameArabic: json['name_arabic'] as String,
      versesCount: json['verses_count'] as int,
      pages: List<int>.from(json['pages']),
      translatedName: TranslatedName.fromJson(json['translated_name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'revelation_place': revelationPlace,
      'revelation_order': revelationOrder,
      'bismillah_pre': bismillahPre,
      'name_simple': nameSimple,
      'name_complex': nameComplex,
      'name_arabic': nameArabic,
      'verses_count': versesCount,
      'pages': pages,
      'translated_name': translatedName.toJson(),
    };
  }
}

@HiveType(typeId: 1)
class TranslatedName extends HiveObject {
  @HiveField(0)
  final String languageName;

  @HiveField(1)
  final String name;

  TranslatedName({required this.languageName, required this.name});

  factory TranslatedName.fromJson(Map<String, dynamic> json) {
    return TranslatedName(
      languageName: json['language_name'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language_name': languageName,
      'name': name,
    };
  }
}

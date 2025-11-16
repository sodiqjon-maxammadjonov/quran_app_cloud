import 'package:hive/hive.dart';

part 'ayah_model.g.dart';

@HiveType(typeId: 2)
class AyahModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int surahId;

  @HiveField(2)
  final int ayahNumber;

  @HiveField(3)
  final int juzNumber;

  @HiveField(4)
  final int pageNumber;

  @HiveField(5)
  final String textArabic;

  @HiveField(6)
  final Map<String, String> translations;

  @HiveField(7)
  final String? audioUrl;

  @HiveField(8)
  final DateTime downloadedAt;

  AyahModel({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.juzNumber,
    required this.pageNumber,
    required this.textArabic,
    required this.translations,
    this.audioUrl,
    required this.downloadedAt,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      id: json['id'] as int,
      surahId: json['chapter_id'] as int,
      ayahNumber: json['verse_number'] as int,
      juzNumber: json['juz_number'] as int? ?? 0,
      pageNumber: json['page_number'] as int? ?? 0,
      textArabic: json['text_arabic'] as String? ?? '',
      translations: Map<String, String>.from(json['translations'] ?? {}),
      audioUrl: json['audio_url'] as String?,
      downloadedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapter_id': surahId,
      'verse_number': ayahNumber,
      'juz_number': juzNumber,
      'page_number': pageNumber,
      'text_arabic': textArabic,
      'translations': translations,
      'audio_url': audioUrl,
      'downloaded_at': downloadedAt.toIso8601String(),
    };
  }

  String? getTranslation(String language) {
    return translations[language];
  }
}

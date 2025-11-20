import 'package:quran_app_cloud/src/data/library/library.dart';

part 'edition_model.g.dart';

@HiveType(typeId: 2)
class EditionModel extends HiveObject {
  @HiveField(0)
  final String identifier;

  @HiveField(1)
  final String language;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String englishName;

  @HiveField(4)
  final String format;

  @HiveField(5)
  final String type;

  @HiveField(6)
  final String direction;

  EditionModel({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory EditionModel.fromJson(Map<String, dynamic> json) {
    return EditionModel(
      identifier: json['identifier'] as String,
      language: json['language'] as String,
      name: json['name'] as String,
      englishName: json['englishName'] as String,
      format: json['format'] as String,
      type: json['type'] as String,
      direction: json['direction'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'language': language,
      'name': name,
      'englishName': englishName,
      'format': format,
      'type': type,
      'direction': direction,
    };
  }
}

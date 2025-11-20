import 'package:hive/hive.dart';
import 'package:quran_app_cloud/src/data/model/edition/edition_model.dart';

part 'ayah_model.g.dart';

@HiveType(typeId: 3)
class AyahModel extends HiveObject {
  @HiveField(0)
  final int number;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int numberInSurah;

  @HiveField(3)
  final int juz;

  @HiveField(4)
  final int manzil;

  @HiveField(5)
  final int page;

  @HiveField(6)
  final int ruku;

  @HiveField(7)
  final int hizbQuarter;

  @HiveField(8)
  final bool sajda;

  @HiveField(9)
  final int surahNumber;

  @HiveField(10)
  final EditionModel edition;

  AyahModel({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    required this.surahNumber,
    required this.edition,
  });

  factory AyahModel.fromJson(
      Map<String, dynamic> json,
      int surahNumber,
      EditionModel edition,
      ) {
    return AyahModel(
      number: json['number'] as int,
      text: json['text'] as String,
      numberInSurah: json['numberInSurah'] as int,
      juz: json['juz'] as int,
      manzil: json['manzil'] as int,
      page: json['page'] as int,
      ruku: json['ruku'] as int,
      hizbQuarter: json['hizbQuarter'] as int,
      sajda: json['sajda'] as bool,
      surahNumber: surahNumber,
      edition: edition,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
      'surahNumber': surahNumber,
      'edition': edition.toJson(),
    };
  }

  /// Unique ID - surah raqami + edition + ayah raqami
  String get id => '${surahNumber}_${edition.identifier}_$number';
}
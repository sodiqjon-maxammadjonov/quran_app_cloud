// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahModelAdapter extends TypeAdapter<SurahModel> {
  @override
  final int typeId = 0;

  @override
  SurahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahModel(
      id: fields[0] as int,
      revelationPlace: fields[1] as String,
      revelationOrder: fields[2] as int,
      bismillahPre: fields[3] as bool,
      nameSimple: fields[4] as String,
      nameComplex: fields[5] as String,
      nameArabic: fields[6] as String,
      versesCount: fields[7] as int,
      pages: (fields[8] as List).cast<int>(),
      translatedName: fields[9] as TranslatedName,
    );
  }

  @override
  void write(BinaryWriter writer, SurahModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.revelationPlace)
      ..writeByte(2)
      ..write(obj.revelationOrder)
      ..writeByte(3)
      ..write(obj.bismillahPre)
      ..writeByte(4)
      ..write(obj.nameSimple)
      ..writeByte(5)
      ..write(obj.nameComplex)
      ..writeByte(6)
      ..write(obj.nameArabic)
      ..writeByte(7)
      ..write(obj.versesCount)
      ..writeByte(8)
      ..write(obj.pages)
      ..writeByte(9)
      ..write(obj.translatedName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TranslatedNameAdapter extends TypeAdapter<TranslatedName> {
  @override
  final int typeId = 1;

  @override
  TranslatedName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranslatedName(
      languageName: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TranslatedName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.languageName)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslatedNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

import 'package:quran_app_cloud/src/data/library/library.dart';

abstract class AyahRepo{
  Future getAyahs(int surahId, String editions);
}

class AyahRepoImpl implements AyahRepo{
  final ApiService api = ApiService();
  final Emitter<AyahState> emit;
  AyahRepoImpl(this.emit);
  @override
  Future getAyahs(int surahId, String editions) async{
   try{final raw = await api.getAyahs(surahId, editions);

   final List<dynamic> dataList = raw["data"];
   final Map<String, List<AyahModel>> result = {};

   for (final item in dataList) {
     final editionJson = item["edition"];
     final edition = EditionModel.fromJson(editionJson);

     final List<dynamic> ayahsJson = item["ayahs"];

     final ayahs = ayahsJson.map((e) {
       return AyahModel.fromJson(
         e,
         item["number"],
         edition,
       );
     }).toList();
     result[edition.identifier] = ayahs;
     emit(AyahLoadedState(result));
   }

   return result;
   } catch (e) {
     print("Repository ERROR: $e");
     rethrow;
   }
  }
}
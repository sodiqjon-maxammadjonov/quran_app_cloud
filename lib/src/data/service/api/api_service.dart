import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../library/library.dart';

class ApiService {
  final String baseUrl = 'https://api.alquran.cloud/v1';

  Future<Map<String, dynamic>> fetchSurahs() async {
    final response = await http.get(
      Uri.parse('https://api.quran.com/api/v4/chapters'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load surahs');
    }
  }


  Future<List<AyahModel>> fetchAyahsBySurah(int surahId) async {
    try {
      print('Surah $surahId ni yuklash boshlandi...');

      // Birinchi surani oyatlar sonini bilish (1-surah 7 oyatli)
      final firstAyahUrl =
          '$baseUrl/surah/$surahId'; // Oyatlar sonini bilish uchun
      final firstResponse = await http.get(Uri.parse(firstAyahUrl));
      final firstData = jsonDecode(firstResponse.body);
      final totalAyahs = firstData['data']['numberOfAyahs'] as int;

      print('Jami oyatlar: $totalAyahs');

      List<AyahModel> ayahs = [];

      // Har bir oyat uchun alohida request (editions bilan)
      for (int ayahNum = 1; ayahNum <= totalAyahs; ayahNum++) {
        try {
          final reference = '$surahId:$ayahNum';

          // Barcha editions bir request da
          final url =
              '$baseUrl/ayah/$reference/editions/quran-uthmani,en.asad,ru.kuliev,uz.sodik,ar.husary';

          final response = await http.get(Uri.parse(url));

          if (response.statusCode != 200) {
            print('⚠️ Oyat $reference: ${response.statusCode}');
            continue;
          }

          final data = jsonDecode(response.body);
          final editions = data['data'] as List? ?? [];

          if (editions.isEmpty) continue;

          // Barcha editions birlashtirish
          final translations = <String, String>{};
          String arabText = '';
          String? audioUrl;
          int juzNum = 0;
          int pageNum = 0;

          for (var edition in editions) {
            final text = edition['text'] as String? ?? '';
            final editionName = edition['edition'] as Map? ?? {};
            final identifier = editionName['identifier'] as String? ?? '';

            if (identifier == 'quran-uthmani') {
              arabText = text;
              juzNum = edition['juz'] as int? ?? 0;
              pageNum = edition['page'] as int? ?? 0;
            } else if (identifier == 'ar.husary') {
              // Audio URL
              audioUrl = edition['audio'] as String?;
            } else if (identifier == 'en.asad') {
              translations['en'] = text;
            } else if (identifier == 'ru.kuliev') {
              translations['ru'] = text;
            } else if (identifier == 'uz.sodik') {
              translations['uz'] = text;
            }
          }

          if (arabText.isEmpty) continue;

          final ayah = AyahModel(
            id: editions.isNotEmpty ? editions[0]['number'] as int? ?? 0 : 0,
            surahId: surahId,
            ayahNumber: ayahNum,
            juzNumber: juzNum,
            pageNumber: pageNum,
            textArabic: arabText,
            translations: translations,
            audioUrl: audioUrl,
            downloadedAt: DateTime.now(),
          );

          ayahs.add(ayah);
          print('✓ Oyat $reference yuklandi');
        } catch (e) {
          print('❌ Oyat $surahId:$ayahNum xatosi: $e');
        }
      }

      print('✅ Jami ${ayahs.length} oyat yuklandi');
      return ayahs;
    } catch (e) {
      print('❌ API xatosi: $e');
      throw Exception('API xatosi: $e');
    }
  }
}
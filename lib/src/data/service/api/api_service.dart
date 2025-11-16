import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../library/library.dart';

class ApiService {
  final String baseUrl = 'https://api.quran.com/api/v4';

  Future<Map<String, dynamic>> fetchSurahs() async {
    final response = await http.get(
      Uri.parse('$baseUrl/chapters'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load surahs');
    }
  }

  Future<List<AyahModel>> fetchAyahsBySurah(int surahId) async {
    try {
      // Bir request da barcha tahrirlar (editions)
      final url =
          '$baseUrl/surah/$surahId/editions/quran-uthmani,en.asad,ru.kuliev,ar.alafasy';

      final response = await http.get(Uri.parse(url));

      print('API URL: $url');
      print('Status: ${response.statusCode}');
      print('Response: ${response.body.substring(0, 200)}');

      if (response.statusCode != 200) {
        throw Exception('API xatosi: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      if (data['code'] != 200) {
        throw Exception(data['message'] ?? 'Noma\'lum xatolik');
      }

      final surahsData = data['data'] as List;
      if (surahsData.isEmpty) {
        throw Exception('Ma\'lumot topilmadi');
      }

      List<AyahModel> ayahs = [];

      // Birinchi tahrir (arab) asosiy hisoblanadi
      final arabEdition = surahsData[0];
      final arabAyahs = arabEdition['ayahs'] as List? ?? [];

      // Qolgan tahrirlari (en, ru, audio)
      final enEdition = surahsData.length > 1 ? surahsData[1] : null;
      final ruEdition = surahsData.length > 2 ? surahsData[2] : null;
      final audioEdition = surahsData.length > 3 ? surahsData[3] : null;

      for (int i = 0; i < arabAyahs.length; i++) {
        final arabAyah = arabAyahs[i];
        final enAyahs = (enEdition?['ayahs'] as List? ?? []);
        final ruAyahs = (ruEdition?['ayahs'] as List? ?? []);
        final audioAyahs = (audioEdition?['ayahs'] as List? ?? []);

        final translations = <String, String>{
          'ar': arabAyah['text'] ?? '',
          'en': i < enAyahs.length ? enAyahs[i]['text'] ?? '' : '',
          'ru': i < ruAyahs.length ? ruAyahs[i]['text'] ?? '' : '',
        };

        final ayah = AyahModel(
          id: arabAyah['number'] as int? ?? 0,
          surahId: surahId,
          ayahNumber: arabAyah['numberInSurah'] as int? ?? i + 1,
          juzNumber: arabAyah['juz'] as int? ?? 0,
          pageNumber: arabAyah['page'] as int? ?? 0,
          textArabic: arabAyah['text'] ?? '',
          translations: translations,
          audioUrl: i < audioAyahs.length ? audioAyahs[i]['audio'] as String? : null,
          downloadedAt: DateTime.now(),
        );

        ayahs.add(ayah);
      }

      print('Yuklangan oyatlar: ${ayahs.length}');
      return ayahs;
    } catch (e) {
      print('API xatosi: $e');
      throw Exception('API xatosi: $e');
    }
  }
}
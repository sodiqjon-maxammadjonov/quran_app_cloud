import 'dart:convert';
import 'dart:developer';
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

  Future<Map<String, dynamic>> fetchAyahsRaw(int surahId) async {
    final editions = AyahEditions.getAll();
    final url = Uri.parse('$baseUrl/surah/$surahId/editions/$editions');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        log(data.toString(), name: 'fetchAyahsRaw');

        if (data is Map<String, dynamic>) {
          return data;
        } else {
          return {'data': data};
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error fetching ayahs: $e');
      return {};
    }
  }
}

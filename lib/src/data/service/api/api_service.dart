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

  Future<Map<String, dynamic>> getAyahs(
      int surahId,
      String editions,
      ) async {
    final url = Uri.parse("$baseUrl/surah/$surahId/editions/$editions");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("API ERROR: $e");
      rethrow;
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/const/app_const.dart';

class PexelsDataSource {
  const PexelsDataSource();

  Future<String?> fetchImageUrl(String query) async {
    final uri = Uri.parse(
      '$pexelsBaseUrl/search'
      '?query=${Uri.encodeQueryComponent(query)}&per_page=1',
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': pexelsApiKey},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال بسيرفر الصور');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final photos = data['photos'] as List<dynamic>?;

    if (photos == null || photos.isEmpty) {
      return null;
    }

    final src = photos.first['src'] as Map<String, dynamic>;
    return src['medium'] as String?;
  }
}

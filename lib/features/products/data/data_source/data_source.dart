import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/const/app_const.dart';
// import '../../../core/const/app_const.dart';

/// خدمة بسيطة للبحث عن صور من Pexels API واستخدامها كـ placeholder
/// لصور المنتجات أثناء التيست.
class PexelsDataSource {
  const PexelsDataSource();

  /// بيدور بكلمة بحث ويرجع أول صورة مناسبة (رابط medium size).
  /// لو مفيش نتائج أو حصل خطأ، بيرجع null.
  Future<String?> fetchImageUrl(String query) async {
    final uri = Uri.parse(
      '$pexelsBaseUrl/search'
      '?query=${Uri.encodeQueryComponent(query)}&per_page=1',
    );

    try {
      final response = await http.get(
        uri,
        headers: {'Authorization': pexelsApiKey},
      );

      if (response.statusCode != 200) {
        return null;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final photos = data['photos'] as List<dynamic>?;

      if (photos == null || photos.isEmpty) {
        return null;
      }

      final src = photos.first['src'] as Map<String, dynamic>;
      return src['medium'] as String?;
    } catch (_) {
      return null;
    }
  }
}

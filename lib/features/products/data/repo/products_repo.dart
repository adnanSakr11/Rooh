import 'package:rooh/features/products/data/models/products_model.dart';
import '../../services/pexels_service.dart';

class ProductRepository {
  final PexelsService _pexelsService;

  const ProductRepository({this._pexelsService = const PexelsService()});

  static const List<_ProductSeed> _seeds = [
    _ProductSeed(
      name: 'مجسم تنين',
      description: 'مجسم تنين مطبوعD3 بتفاصيل دقيقة، مناسب للديكور والهدايا.',
      price: 250,
      searchQuery: '3d printed dragon figurine',
    ),
    _ProductSeed(
      name: 'لعبة روبوت',
      description: 'لعبة روبوت متحركة الأجزاء، مطبوعة بجودة عالية وألوان مقاومة.',
      price: 180,
      searchQuery: '3d printed robot toy',
    ),
    _ProductSeed(
      name: 'قطعة ديكور هندسية',
      description: 'قطعة ديكور بتصميم هندسي عصري تناسب الطاولات والرفوف.',
      price: 150,
      searchQuery: '3d printed geometric decor',
    ),
    _ProductSeed(
      name: 'مجسم مخصص بالاسم',
      description: 'مجسم شخصي مطبوع حسب طلبك، ممكن تحدد الاسم والشكل واللون.',
      price: 300,
      searchQuery: 'custom 3d printed gift',
    ),

    _ProductSeed(
      name: 'مجسم تنين',
      description: 'مجسم تنين مطبوعD3 بتفاصيل دقيقة، مناسب للديكور والهدايا.',
      price: 250,
      searchQuery: '3d printed dragon figurine',
    ),
    _ProductSeed(
      name: 'لعبة روبوت',
      description: 'لعبة روبوت متحركة الأجزاء، مطبوعة بجودة عالية وألوان مقاومة.',
      price: 180,
      searchQuery: '3d printed robot toy',
    ),
    _ProductSeed(
      name: 'قطعة ديكور هندسية',
      description: 'قطعة ديكور بتصميم هندسي عصري تناسب الطاولات والرفوف.',
      price: 150,
      searchQuery: '3d printed geometric decor',
    ),
    _ProductSeed(
      name: 'مجسم مخصص بالاسم',
      description: 'مجسم شخصي مطبوع حسب طلبك، ممكن تحدد الاسم والشكل واللون.',
      price: 300,
      searchQuery: 'custom 3d printed gift',
    ),
    _ProductSeed(
      name: 'مجسم تنين',
      description: 'مجسم تنين مطبوعD3 بتفاصيل دقيقة، مناسب للديكور والهدايا.',
      price: 250,
      searchQuery: '3d printed dragon figurine',
    ),
    _ProductSeed(
      name: 'لعبة روبوت',
      description: 'لعبة روبوت متحركة الأجزاء، مطبوعة بجودة عالية وألوان مقاومة.',
      price: 180,
      searchQuery: '3d printed robot toy',
    ),
    _ProductSeed(
      name: 'قطعة ديكور هندسية',
      description: 'قطعة ديكور بتصميم هندسي عصري تناسب الطاولات والرفوف.',
      price: 150,
      searchQuery: '3d printed geometric decor',
    ),
    _ProductSeed(
      name: 'مجسم مخصص بالاسم',
      description: 'مجسم شخصي مطبوع حسب طلبك، ممكن تحدد الاسم والشكل واللون.',
      price: 300,
      searchQuery: 'custom 3d printed gift',
    ),
  ];

  /// بيرجع قائمة منتجات كاملة بعد ما يجيب صورة حقيقية من Pexels لكل واحد.
  /// لو الصورة مش موجودة لأي سبب، بيتحط رابط افتراضي بدالها.
  Future<List<ProductsModel>> fetchProducts() async {
    final products = await Future.wait(
      _seeds.map((seed) async {
        final imageUrl =
            await _pexelsService.fetchImageUrl(seed.searchQuery) ??
            _fallbackImageUrl;

        return ProductsModel(
          name: seed.name,
          description: seed.description,
          price: seed.price,
          imageUrl: imageUrl,
        );
      }),
    );

    return products;
  }

  static const String _fallbackImageUrl =
      'https://images.pexels.com/photos/3183150/pexels-photo-3183150.jpeg';
}

class _ProductSeed {
  final String name;
  final String description;
  final double price;
  final String searchQuery;

  const _ProductSeed({
    required this.name,
    required this.description,
    required this.price,
    required this.searchQuery,
  });
}
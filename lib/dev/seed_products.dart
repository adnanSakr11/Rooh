// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../features/products/data/data_source/data_source.dart';
// import '../features/products/data/data_source/products_data_source.dart';
// import '../features/products/data/data_source/products_seed_data.dart';
// import '../features/products/data/model/products_model.dart';

// Future<void> seedProducts() async {
//   const pexels = PexelsDataSource();
//   final dataSource = ProductsDataSource(FirebaseFirestore.instance);
//   const fallback =
//       'https://images.pexels.com/photos/3183150/pexels-photo-3183150.jpeg';

//   for (final seed in seeds) {
//     final imgUrl = await pexels.fetchImageUrl(seed.searchQuery) ?? fallback;
//     await dataSource.createProduct(
//       ProductsModel(
//         id: seed.id,
//         name: seed.name,
//         desc: seed.description,
//         price: seed.price,
//         imgUrl: imgUrl,
//       ),
//     );
//   }
// }
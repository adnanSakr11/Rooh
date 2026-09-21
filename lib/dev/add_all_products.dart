import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooh/core/injection/service_locator.dart';
import 'package:rooh/features/products/data/data_source/products_data_source.dart';
import 'package:rooh/features/products/data/model/products_model.dart';

List<ProductsModel> products = [
  ProductsModel(
    id: '8',
    name: 'مفاتيح جي تي آر نيزمو',
    desc: 'حامل مفاتيح حائطي بتصميم  نيسان جي تي آر نيزمو',
    price: 200,
    imgUrl: 'https://i.ibb.co/CKBzgkrS/5870826406936252508-121.jpg',
  ),
];

Future<void> setProduct() async {
  ProductsDataSource productsDataSource = ProductsDataSource(
    getIt<FirebaseFirestore>(),
  );
  for (var i = 0; i < products.length; i++) {
    await productsDataSource.createProduct(products[i]);
  }
  return;
}

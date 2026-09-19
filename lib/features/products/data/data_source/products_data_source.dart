import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooh/features/products/data/model/products_model.dart';

class ProductsDataSource {
  final FirebaseFirestore _firestore;
  const ProductsDataSource(this._firestore);
  CollectionReference<Map<String, dynamic>> get _productsRef =>
      _firestore.collection('products');

  Future<ProductsModel?> getProductsData(String id) async {
    final doc = await _productsRef.doc(id).get();
    if (!doc.exists) return null;
    return ProductsModel.fromMap(doc.data()!);
  }

  Future<void> createProduct(ProductsModel product) async {
    return await _productsRef.doc(product.id).set(product.toMap());
  }

  Future<List<ProductsModel>> getAllProducts() async {
    final snapshot = await _productsRef.get();
    return snapshot.docs
        .map((doc) => ProductsModel.fromMap(doc.data()))
        .toList();
  }
}

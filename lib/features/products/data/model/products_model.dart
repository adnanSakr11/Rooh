import 'package:rooh/features/products/domain/entity/products_entity.dart';

class ProductsModel extends ProductsEntity {
  const ProductsModel({
    required super.id,
    required super.name,
    required super.desc,
    required super.price,
    required super.imgUrl,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> map,String id) {
    return ProductsModel(
      id: id,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: (map['price'] as num).toDouble(),
      imgUrl: map['imgUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'imgUrl': imgUrl,
    };
  }
}

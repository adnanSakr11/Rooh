import 'package:flutter/material.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/shared/widgets/app_network_image.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product, required this.colors});

  final ProductsEntity product;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.primary.withOpacity(0.3)),
        ),
        clipBehavior: Clip.antiAlias,
        child: AppNetworkImage(url: product.imgUrl, fit: BoxFit.cover),
      ),
    );
  }
}

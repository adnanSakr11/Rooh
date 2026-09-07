import 'package:flutter/material.dart';
import '../../domain/entity/products_entity.dart';
import '../extensions/products_extensions.dart';
import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productsModel});

  final ProductsEntity productsModel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: productsModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: colors.onSurface.withOpacity(0.2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                productsModel.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colors.onSurface.withOpacity(0.05),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: colors.onSurface.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentGeometry.topRight,
                    child: Text(
                      productsModel.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productsModel.formattedPrice,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

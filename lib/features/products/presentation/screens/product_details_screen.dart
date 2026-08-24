import 'package:flutter/material.dart';
import 'package:rooh/features/products/data/models/products_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: colors.surface,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colors.onSurface.withOpacity(0.05),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 60,
                    color: colors.onSurface.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.formattedPrice,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: colors.onSurface.withOpacity(0.8),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
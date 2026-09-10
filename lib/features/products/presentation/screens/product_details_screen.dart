import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';

import '../widgets/product_image.dart';
import '../widgets/product_info.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductsEntity product;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 15),
                      ProductImage(product: product, colors: colors),
                      const SizedBox(height: 24),
                      ProductInfo(
                        product: product,
                        colors: colors,
                        isMobile: true,
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: ProductImage(product: product, colors: colors),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 4,
                        child: ProductInfo(
                          product: product,
                          colors: colors,
                          isMobile: false,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

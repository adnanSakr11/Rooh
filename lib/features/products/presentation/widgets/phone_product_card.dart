import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';

import '../extensions/products_extensions.dart';
import '../screens/product_details_screen.dart';

class PhoneProductCard extends StatelessWidget {
  final ProductsEntity productsEntity;
  const PhoneProductCard({super.key, required this.productsEntity});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: productsEntity),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 38, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      productsEntity.name,
                      style: TextStyle(
                        letterSpacing: -1,
                        fontSize: 20,
                        fontFamily: fontFamily,
                        color: colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      productsEntity.formattedPrice,
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors.secondary,
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(productsEntity.imageUrl, fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}

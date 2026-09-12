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
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colors.surface.withOpacity(0.95),
            border: Border.all(
              color: colors.primary.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
                offset: Offset(4, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        productsEntity.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: fontFamily,
                          color: colors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        productsEntity.formattedPrice,
                        style: TextStyle(
                          fontSize: 16,
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 95,
                  width: 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: colors.secondary,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    productsEntity.imageUrl,
                    fit: BoxFit.fill,
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

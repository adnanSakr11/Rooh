import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/products/presentation/widgets/trust_row.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../cart/presentation/cubits/cart/cart_cubit.dart';
import '../../domain/entity/products_entity.dart';
import '../extensions/products_extensions.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.product,
    required this.colors,
    required this.isMobile,
  });

  final ProductsEntity product;
  final ColorScheme colors;
  final bool isMobile;

  void addToCart(BuildContext context) async {
    final result = await context.read<CartCubit>().addToCart(product.id);
    if (!context.mounted) return;

    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            failure.message,
            style: TextStyle(fontFamily: fontFamily),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      ),
      (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تمت الإضافة للسلة',
            style: TextStyle(fontFamily: fontFamily),
          ),
          backgroundColor: colors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          product.name,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: isMobile ? 26 : 32,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          product.formattedPrice,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: isMobile ? 22 : 26,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 20),
        Divider(color: colors.onSurface.withOpacity(0.1)),
        const SizedBox(height: 20),
        Text(
          product.description,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            height: 1.7,
            color: colors.onSurface.withOpacity(0.75),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: colors.onSurface.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: colors.primary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'صناعة يدوية في مصر | التوصيل خلال 3-5 أيام',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13,
                    color: colors.onSurface.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'اضافة الى العربة',
          backgroundColor: colors.primary.withOpacity(0.15),
          textColor: colors.primary,
          onTap: () => addToCart(context),
        ),
        const SizedBox(height: 12),
        AppButton(
          text: 'اشتري الأن',
          backgroundColor: colors.primary,
          textColor: colors.surface,
        ),
        const SizedBox(height: 24),
        TrustRow(colors: colors),
      ],
    );
  }
}


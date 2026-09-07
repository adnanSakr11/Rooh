import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/shared/widgets/app_button.dart';
import '../../../cart/presentation/cubits/cart/cart_cubit.dart';
import '../extensions/products_extensions.dart';

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
                      _ProductImage(product: product, colors: colors),
                      const SizedBox(height: 24),
                      _ProductInfo(
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
                        child: _ProductImage(product: product, colors: colors),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 4,
                        child: _ProductInfo(
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

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product, required this.colors});

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
        child: Image.network(
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
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({
    required this.product,
    required this.colors,
    required this.isMobile,
  });

  final ProductsEntity product;
  final ColorScheme colors;
  final bool isMobile;

  void _addToCart(BuildContext context) async {
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
          onTap: () => _addToCart(context),
        ),
        const SizedBox(height: 12),
        AppButton(
          text: 'اشتري الأن',
          backgroundColor: colors.primary,
          textColor: colors.surface,
        ),
        const SizedBox(height: 24),
        _TrustRow(colors: colors),
      ],
    );
  }
}

class _TrustRow extends StatelessWidget {
  const _TrustRow({required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.local_shipping_outlined, 'شحن مجاني'),
      (Icons.replay_outlined, 'إرجاع خلال 14 يوم'),
      (Icons.verified_outlined, 'ضمان الجودة'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((item) {
        return Column(
          children: [
            Icon(item.$1, color: colors.onSurface.withOpacity(0.6)),
            const SizedBox(height: 6),
            Text(
              item.$2,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 11,
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

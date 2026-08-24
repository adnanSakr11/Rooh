import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/products/data/models/products_model.dart';
import 'package:rooh/shared/widgets/app_search_bar.dart';
import '../../data/repo/products_repo.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductRepository _repository = const ProductRepository();
  late Future<List<ProductsModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _repository.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: FutureBuilder<List<ProductsModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('حصل خطأ في تحميل المنتجات'));
          }

          final products = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.notifications_none,
                            size: 28,
                            color: colors.onSurface,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: AppSearchBar(
                              fillColor: colors.surface,
                              hintText: 'ابحث عن منتجك',
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: colors.onSurface,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'المنتجات',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];

                    return ProductCard(productsModel: product);
                  }, childCount: products.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/const/app_const.dart';

class CartFooter extends StatelessWidget {
  const CartFooter({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: colors.onSurface, width: 2),
            borderRadius: BorderRadius.circular(18),
            color: colors.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 3,
                offset: const Offset(-4, 5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: colors.surface.withOpacity(0.8),
                    border: Border.all(color: colors.onSurface),
                  ),
                  child: Center(
                    child: Text(
                      'جنيه ${totalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                ),
                Text(
                  'إتمام الطلب',
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: fontFamily,
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

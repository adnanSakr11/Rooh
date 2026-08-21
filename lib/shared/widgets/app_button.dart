import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: height ?? 55,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor ?? colors.primary,
          border: Border.all(color: colors.onSurface, width: 1),
        ),
        child: isLoading
            ? CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[const SizedBox(width: 12), icon!],
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? colors.onSurface,
                      fontSize: fontSize ?? 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontFamily: fontFamily,
                    ),
                  ),
                  //if (icon != null) ...[const SizedBox(width: 12), icon!],
                ],
              ),
      ),
    );
  }
}

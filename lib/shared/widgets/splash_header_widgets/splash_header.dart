import 'package:flutter/material.dart';

import '../../../core/const/app_const.dart';
import '../../../core/const/splash_const.dart';

class SplashHeader extends StatelessWidget {
  const SplashHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Image.asset(
          logoAsset,
          height: SplashConstants.logoHeight,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.image_not_supported_outlined,
            size: SplashConstants.logoHeight * 0.6,
            color: colors.onSurface.withOpacity(0.3),
          ),
        ),
        const SizedBox(height: SplashConstants.spacingLogoToTitle),
        Text(
          'روح',
          style: textTheme.headlineMedium!.copyWith(
            fontFamily: fontFamily,
            fontSize: SplashConstants.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: SplashConstants.spacingTitleToSubtitle),
        Text(
          'من فكرتك... لقطعة لها روح',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge!.copyWith(
            fontFamily: fontFamily,
            fontSize: SplashConstants.subtitleFontSize,
            fontWeight: FontWeight.w400,
            color: colors.onSurface.withOpacity(
              SplashConstants.subtitleOpacity,
            ),
          ),
        ),
      ],
    );
  }
}
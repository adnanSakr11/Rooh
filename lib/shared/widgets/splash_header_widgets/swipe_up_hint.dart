import 'package:flutter/material.dart';
import '../../../core/const/app_const.dart';
import '../../../core/const/splash_const.dart';

class SwipeUpHint extends StatelessWidget {
  const SwipeUpHint({super.key, required this.pulse});

  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        return Opacity(opacity: pulse.value, child: child);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.keyboard_arrow_up_rounded,
            color: colors.onSurface.withOpacity(SplashConstants.hintOpacity),
            size: 28,
          ),
          Text(
            'اسحب لأعلى للمتابعة',
            style: textTheme.bodySmall!.copyWith(
              fontFamily: fontFamily,
              fontSize: SplashConstants.hintFontSize,
              color: colors.onSurface.withOpacity(SplashConstants.hintOpacity),
            ),
          ),
        ],
      ),
    );
  }
}

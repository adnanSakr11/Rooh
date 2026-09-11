import 'package:flutter/material.dart';
class SwipeUpPageRoute<T> extends PageRouteBuilder<T> {
  SwipeUpPageRoute({required WidgetBuilder builder, super.settings})
    : super(
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // الشاشة الجديدة بتدخل من تحت شوية لفوق، بنفس اتجاه السحب.
          final slideIn = Tween<Offset>(
            begin: const Offset(0, 0.25),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );

          final fadeIn = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          );

          return FadeTransition(
            opacity: fadeIn,
            child: SlideTransition(position: slideIn, child: child),
          );
        },
      );
}
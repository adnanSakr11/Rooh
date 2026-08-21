import 'package:flutter/material.dart';

/// ثوابت خاصة بشاشة الـ Splash فقط.
/// فصلناها هنا بدل ما تكون أرقام سايبة (magic numbers) جوه الـ widget
/// عشان لو حد غيّرها بعدين يلاقيها في مكان واحد، ومفيهاش لبس مع ثوابت
/// أجزاء تانية من التطبيق.
class SplashConstants {
  const SplashConstants._();

  static const Duration animationDuration = Duration(milliseconds: 900);

  static const double logoHeight = 200;
  static const double titleFontSize = 45;
  static const double subtitleFontSize = 17;
  static const double hintFontSize = 14;

  static const double spacingLogoToTitle = 12;
  static const double spacingTitleToSubtitle = 8;

  // نسب الـ Spacer بين أجزاء الشاشة (فوق : وسط : تحت)
  static const int flexTop = 3;
  static const int flexMiddle = 4;
  static const int flexBottom = 3;

  static const Offset headerSlideBegin = Offset(0, -0.3);

  static const double subtitleOpacity = 0.7;
  static const double hintOpacity = 0.5;



  // إعدادات إيماءة السحب لفوق
  // الحد الأدنى للمسافة (بالبكسل) عشان نعتبرها swipe حقيقي مش لمسة عرضية
  static const double swipeUpDistanceThreshold = 40;
  // الحد الأدنى للسرعة (velocity) عشان نفرّق بين سحب مقصود ولمسة بسيطة
  static const double swipeUpVelocityThreshold = 200;

  // توقيت ظهور تلميح "اسحب لأعلى" بعد ما أنيميشن الدخول يخلص
  static const Duration hintAppearDelay = Duration(seconds: 2);
  static const Duration hintPulseDuration = Duration(milliseconds: 1400);

  // أنيميشن الخروج لما اليوزر يسحب/يلمس، قبل الانتقال للشاشة التانية
  static const Duration exitAnimationDuration = Duration(milliseconds: 350);
  static const Offset exitSlideEnd = Offset(0, -0.35);
}
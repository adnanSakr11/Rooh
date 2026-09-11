import 'package:flutter/material.dart';
import '../../core/const/splash_const.dart';
import '../widgets/splash_header_widgets/splash_header.dart';
import '../widgets/splash_header_widgets/swipe_up_hint.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.onContinue});

  final VoidCallback? onContinue;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // أنيميشن الدخول (اللوجو والعنوان)
  late final AnimationController _entryController;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _fade;

  // أنيميشن نبض التلميح ("اسحب لأعلى")
  late final AnimationController _hintController;
  late final Animation<double> _hintPulse;

  // أنيميشن الخروج لما اليوزر يسحب/يلمس عشان ننتقل للشاشة التانية
  late final AnimationController _exitController;
  late final Animation<Offset> _exitSlide;
  late final Animation<double> _exitFade;

  bool _isHintVisible = false;
  bool _hasTriggeredContinue = false;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: SplashConstants.animationDuration,
    );

    _headerSlide =
        Tween<Offset>(
          begin: SplashConstants.headerSlideBegin,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _entryController,
            curve: Curves.easeInOutCubic,
          ),
        );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeIn));

    _hintController = AnimationController(
      vsync: this,
      duration: SplashConstants.hintPulseDuration,
    );

    _hintPulse = Tween<double>(begin: 0.35, end: 0.9).animate(
      CurvedAnimation(parent: _hintController, curve: Curves.easeInOut),
    );

    _exitController = AnimationController(
      vsync: this,
      duration: SplashConstants.exitAnimationDuration,
    );

    // المحتوى كله بيتحرك لفوق ويختفي، بنفس اتجاه سحبة اليوزر، عشان
    // يحس إن الشاشة الجاية "مكملة" مش حاجة منفصلة.
    _exitSlide =
        Tween<Offset>(
          begin: Offset.zero,
          end: SplashConstants.exitSlideEnd,
        ).animate(
          CurvedAnimation(parent: _exitController, curve: Curves.easeInCubic),
        );

    _exitFade = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeIn));

    _entryController.forward();

    // التلميح بيظهر بعد ما أنيميشن الدخول ياخد وقته، مش فوراً، عشان
    // يسيب للشاشة إحساسها الهادي الأول من غير أي إلهاء.
    Future.delayed(SplashConstants.hintAppearDelay, () {
      if (!mounted) return;
      setState(() => _isHintVisible = true);
      _hintController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _hintController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  Future<void> _triggerContinue() async {
    // بنمنع تكرار الاستدعاء لو اليوزر سحب/لمس أكتر من مرة بسرعة.
    if (_hasTriggeredContinue) return;
    _hasTriggeredContinue = true;

    _hintController.stop();

    // بنستنى exit animation تخلص الأول، عشان الانتقال يحس إنه متصل
    // بصرياً بدل ما يقطع فجأة في نص حركة السحب.
    await _exitController.forward();

    if (!mounted) return;
    widget.onContinue?.call();
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    // primaryVelocity بيبقى سالب لما السحب يكون لفوق
    if (velocity < -SplashConstants.swipeUpVelocityThreshold) {
      _triggerContinue();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragEnd: _handleVerticalDragEnd,
        onTap: _triggerContinue,
        child: SafeArea(
          child: SlideTransition(
            position: _exitSlide,
            child: FadeTransition(
              opacity: _exitFade,
              child: Center(
                child: Column(
                  children: [
                    const Spacer(flex: SplashConstants.flexTop),
                    SlideTransition(
                      position: _headerSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: const SplashHeader(),
                      ),
                    ),
                    const Spacer(flex: SplashConstants.flexMiddle),
                    AnimatedOpacity(
                      opacity: _isHintVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: SwipeUpHint(pulse: _hintPulse),
                    ),
                    const Spacer(flex: SplashConstants.flexBottom),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

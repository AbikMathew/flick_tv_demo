import 'package:flutter/material.dart';

import 'animation_constants.dart';

/// Factory for creating staggered animations for the success screen
class AnimationBuilder {
  AnimationBuilder._();

  static Animation<double> createWalletScale(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          AnimationConstants.walletScaleStart,
          AnimationConstants.walletScaleEnd,
          curve: Curves.elasticOut,
        ),
      ),
    );
  }

  static Animation<double> createWalletPosition(AnimationController controller) {
    return Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          AnimationConstants.walletPositionStart,
          AnimationConstants.walletPositionEnd,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
  }

  static Animation<double> createTitleFade(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          AnimationConstants.titleFadeStart,
          AnimationConstants.titleFadeEnd,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  static Animation<Offset> createTitleSlide(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(
        AnimationConstants.titleSlideX,
        AnimationConstants.titleSlideY,
      ),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          AnimationConstants.titleFadeStart,
          AnimationConstants.titleFadeEnd,
          curve: Curves.easeOutBack,
        ),
      ),
    );
  }

  static Animation<double> createCardFade(
    AnimationController controller,
    double start,
    double end,
  ) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  static Animation<Offset> createCardSlide(
    AnimationController controller,
    double start,
    double end,
  ) {
    return Tween<Offset>(
      begin: const Offset(
        AnimationConstants.cardSlideX,
        AnimationConstants.cardSlideY,
      ),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeOutQuad),
      ),
    );
  }

  static Animation<double> createActionsFade(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          AnimationConstants.actionStart,
          AnimationConstants.actionEnd,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  static Animation<Offset> createActionsSlide(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(
        AnimationConstants.actionsSlideX,
        AnimationConstants.actionsSlideY,
      ),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          AnimationConstants.actionStart,
          AnimationConstants.actionEnd,
          curve: Curves.easeOutQuad,
        ),
      ),
    );
  }

  static Animation<double> createAppBarFade(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          AnimationConstants.appBarFadeStart,
          AnimationConstants.appBarFadeEnd,
          curve: Curves.easeIn,
        ),
      ),
    );
  }
}

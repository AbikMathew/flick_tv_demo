import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dimension_constants.dart';

/// Displays the "blinkit MONEY" title with fade and slide animations
class MoneyTitleSection extends StatelessWidget {
  const MoneyTitleSection({
    super.key,
    required this.titleFade,
    required this.titleSlide,
  });

  final Animation<double> titleFade;
  final Animation<Offset> titleSlide;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: titleFade,
      child: SlideTransition(
        position: titleSlide,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'blinkit',
              style: TextStyle(
                fontSize: DimensionConstants.titleFontSize,
                fontWeight: FontWeight.w900,
                color: ColorConstants.textWhite,
                letterSpacing: DimensionConstants.titleLetterSpacing,
              ),
            ),
            const SizedBox(height: DimensionConstants.spacingSmall),
            Text(
              'MONEY',
              style: TextStyle(
                fontSize: DimensionConstants.moneyFontSize,
                fontWeight: FontWeight.w900,
                color: ColorConstants.textWhite,
                letterSpacing: DimensionConstants.moneyLetterSpacing,
                shadows: [
                  Shadow(
                    color: ColorConstants.shadowColor,
                    offset: const Offset(
                      DimensionConstants.shadowOffsetX,
                      DimensionConstants.shadowOffsetY,
                    ),
                    blurRadius: DimensionConstants.shadowBlurRadius,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

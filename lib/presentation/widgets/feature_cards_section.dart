import 'package:flutter/material.dart';

import '../../core/constants/dimension_constants.dart';
import '../../domain/entities/feature_item.dart';
import 'action_buttons.dart';
import 'feature_card.dart';

/// Displays the feature cards and action buttons section with staggered animations
class FeatureCardsSection extends StatelessWidget {
  const FeatureCardsSection({
    super.key,
    required this.features,
    required this.card1Fade,
    required this.card1Slide,
    required this.card2Fade,
    required this.card2Slide,
    required this.card3Fade,
    required this.card3Slide,
    required this.actionsFade,
    required this.actionsSlide,
    required this.onAddMoneyPressed,
    required this.onClaimGiftCardTapped,
  });

  final List<FeatureItem> features;
  final Animation<double> card1Fade;
  final Animation<Offset> card1Slide;
  final Animation<double> card2Fade;
  final Animation<Offset> card2Slide;
  final Animation<double> card3Fade;
  final Animation<Offset> card3Slide;
  final Animation<double> actionsFade;
  final Animation<Offset> actionsSlide;
  final VoidCallback onAddMoneyPressed;
  final VoidCallback onClaimGiftCardTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Feature Card 1
        if (features.isNotEmpty)
          FadeTransition(
            opacity: card1Fade,
            child: SlideTransition(
              position: card1Slide,
              child: FeatureCard(item: features[0]),
            ),
          ),

        // Feature Card 2
        if (features.length > 1)
          FadeTransition(
            opacity: card2Fade,
            child: SlideTransition(
              position: card2Slide,
              child: FeatureCard(item: features[1]),
            ),
          ),

        // Feature Card 3
        if (features.length > 2)
          FadeTransition(
            opacity: card3Fade,
            child: SlideTransition(
              position: card3Slide,
              child: FeatureCard(item: features[2]),
            ),
          ),

        const SizedBox(height: DimensionConstants.spacingMedium),

        // Action Buttons Section
        FadeTransition(
          opacity: actionsFade,
          child: SlideTransition(
            position: actionsSlide,
            child: Column(
              children: [
                AddMoneyButton(onPressed: onAddMoneyPressed),
                const SizedBox(height: DimensionConstants.spacingLarge),
                ClaimGiftCardTile(onTap: onClaimGiftCardTapped),
                const SizedBox(height: DimensionConstants.spacingMedium),
                const WatermarkFooter(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

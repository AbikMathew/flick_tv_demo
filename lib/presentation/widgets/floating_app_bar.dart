import 'package:flutter/material.dart';

import '../../core/constants/dimension_constants.dart';
import 'round_action_button.dart';

/// Floating app bar with back and settings buttons
class FloatingAppBar extends StatelessWidget {
  const FloatingAppBar({
    super.key,
    required this.appBarFade,
    required this.safeTop,
    required this.onBackPressed,
    required this.onSettingsPressed,
  });

  final Animation<double> appBarFade;
  final double safeTop;
  final VoidCallback onBackPressed;
  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: safeTop + DimensionConstants.floatingBarTopOffset,
      left: DimensionConstants.floatingBarLeftOffset,
      right: DimensionConstants.floatingBarRightOffset,
      child: FadeTransition(
        opacity: appBarFade,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundActionButton(
              icon: Icons.chevron_left_rounded,
              onTap: onBackPressed,
            ),
            RoundActionButton(
              icon: Icons.settings_outlined,
              onTap: onSettingsPressed,
            ),
          ],
        ),
      ),
    );
  }
}

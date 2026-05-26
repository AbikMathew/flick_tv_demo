import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dimension_constants.dart';

/// A circular action button for the floating app bar
class RoundActionButton extends StatelessWidget {
  const RoundActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.floatingButtonBackground,
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorConstants.floatingButtonBorder,
          width: DimensionConstants.floatingButtonBorderWidth,
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: ColorConstants.iconWhite,
          size: DimensionConstants.floatingButtonSize,
        ),
        onPressed: onTap,
        splashRadius: DimensionConstants.floatingButtonSplashRadius,
      ),
    );
  }
}

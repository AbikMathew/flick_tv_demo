/// Dimension and spacing constants for the success screen
class DimensionConstants {
  // Horizontal spacing
  static const double screenHorizontalPadding = 16.0;

  // Vertical spacing
  static const double topSpacerHeight = 24.0;
  static const double spacingSmall = 2.0;
  static const double spacingMedium = 12.0;
  static const double spacingLarge = 20.0;
  static const double spacingXLarge = 24.0;
  static const double spacingSection = 36.0;

  // Wallet dimensions
  static const double walletHeight = 110.0;
  static const double walletCenterPosition = 0.45;

  // Title styling
  static const double titleFontSize = 28.0;
  static const double titleLetterSpacing = -0.5;
  static const double moneyFontSize = 48.0;
  static const double moneyLetterSpacing = 10.0;

  // Shadows
  static const double shadowBlurRadius = 8.0;
  static const double shadowOffsetY = 4.0;
  static const double shadowOffsetX = 0.0;
  static const double shadowAlpha = 0.3;

  // Floating action bar
  static const double floatingBarTopOffset = 10.0;
  static const double floatingBarLeftOffset = 16.0;
  static const double floatingBarRightOffset = 16.0;
  static const double floatingButtonSize = 24.0;
  static const double floatingButtonContainerAlpha = 0.4;
  static const double floatingButtonBorderAlpha = 0.08;
  static const double floatingButtonBorderWidth = 1.0;
  static const double floatingButtonSplashRadius = 24.0;

  // Loading state
  static const double loadingPlaceholderHeight = 300.0;

  // Scroll physics
  static const double scrollBottomMargin = 50.0;

  // Centered wallet offset calculation
  static double calculateCenterSpacerHeight(
    double screenHeight,
    double safeTop,
  ) {
    return (screenHeight * walletCenterPosition) - (walletHeight / 2) - safeTop;
  }
}

import 'package:flutter/material.dart';

import '../../core/bloc/bloc_provider.dart';
import '../../core/constants/animation_builder.dart';
import '../../core/constants/animation_constants.dart';
import '../../core/constants/dimension_constants.dart';
import '../cubit/success_screen_cubit.dart';
import '../cubit/success_screen_state.dart';
import '../widgets/confetti_overlay.dart';
import '../widgets/dotted_background.dart';
import '../widgets/feature_cards_section.dart';
import '../widgets/floating_app_bar.dart';
import '../widgets/money_title_section.dart';
import '../widgets/wallet_widget.dart';

class SuccessScreenPage extends StatefulWidget {
  const SuccessScreenPage({super.key});

  @override
  State<SuccessScreenPage> createState() => _SuccessScreenPageState();
}

class _SuccessScreenPageState extends State<SuccessScreenPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final GlobalKey<ConfettiOverlayState> _confettiKey =
      GlobalKey<ConfettiOverlayState>();

  // Staggered Animations
  late final Animation<double> _walletScale;
  late final Animation<double> _walletPosition;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _card1Fade;
  late final Animation<Offset> _card1Slide;
  late final Animation<double> _card2Fade;
  late final Animation<Offset> _card2Slide;
  late final Animation<double> _card3Fade;
  late final Animation<Offset> _card3Slide;
  late final Animation<double> _actionsFade;
  late final Animation<Offset> _actionsSlide;
  late final Animation<double> _appBarFade;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AnimationConstants.totalDurationMs),
    );

    // Create all animations using the builder
    _walletScale = AnimationBuilder.createWalletScale(_animationController);
    _walletPosition = AnimationBuilder.createWalletPosition(_animationController);
    _titleFade = AnimationBuilder.createTitleFade(_animationController);
    _titleSlide = AnimationBuilder.createTitleSlide(_animationController);
    _card1Fade = AnimationBuilder.createCardFade(
      _animationController,
      AnimationConstants.card1Start,
      AnimationConstants.card1End,
    );
    _card1Slide = AnimationBuilder.createCardSlide(
      _animationController,
      AnimationConstants.card1Start,
      AnimationConstants.card1End,
    );
    _card2Fade = AnimationBuilder.createCardFade(
      _animationController,
      AnimationConstants.card2Start,
      AnimationConstants.card2End,
    );
    _card2Slide = AnimationBuilder.createCardSlide(
      _animationController,
      AnimationConstants.card2Start,
      AnimationConstants.card2End,
    );
    _card3Fade = AnimationBuilder.createCardFade(
      _animationController,
      AnimationConstants.card3Start,
      AnimationConstants.card3End,
    );
    _card3Slide = AnimationBuilder.createCardSlide(
      _animationController,
      AnimationConstants.card3Start,
      AnimationConstants.card3End,
    );
    _actionsFade = AnimationBuilder.createActionsFade(_animationController);
    _actionsSlide = AnimationBuilder.createActionsSlide(_animationController);
    _appBarFade = AnimationBuilder.createAppBarFade(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SuccessScreenCubit>(context).loadFeatures();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _triggerSuccessBurst() {
    _confettiKey.currentState?.burst();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double safeTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: DottedBackground(
        child: ConfettiOverlay(
          key: _confettiKey,
          triggerOnStart: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double screenHeight = constraints.maxHeight;
              final double centerSpacerHeight =
                  DimensionConstants.calculateCenterSpacerHeight(
                screenHeight,
                safeTop,
              );

              return Stack(
                children: [
                  // Main scrollable content
                  Positioned.fill(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensionConstants.screenHorizontalPadding,
                        ),
                        child: Column(
                          children: [
                            // Dynamic spacer for wallet positioning
                            AnimatedBuilder(
                              animation: _walletPosition,
                              builder: (context, child) {
                                final double currentSpacer =
                                    DimensionConstants.topSpacerHeight +
                                    (centerSpacerHeight -
                                            DimensionConstants.topSpacerHeight) *
                                        _walletPosition.value;
                                return SizedBox(height: safeTop + currentSpacer);
                              },
                            ),

                            // Animated Wallet
                            ScaleTransition(
                              scale: _walletScale,
                              child: const WalletWidget(),
                            ),
                            const SizedBox(
                              height: DimensionConstants.spacingXLarge,
                            ),

                            // Title Section
                            MoneyTitleSection(
                              titleFade: _titleFade,
                              titleSlide: _titleSlide,
                            ),
                            const SizedBox(
                              height: DimensionConstants.spacingSection,
                            ),

                            // Feature Cards & Buttons
                            BlocBuilder<SuccessScreenCubit, SuccessScreenState>(
                              builder: (context, state) {
                                if (state is SuccessScreenLoading ||
                                    state is SuccessScreenInitial) {
                                  return const SizedBox(
                                    height: DimensionConstants
                                        .loadingPlaceholderHeight,
                                  );
                                }

                                final features =
                                    (state as SuccessScreenLoaded).features;

                                return FeatureCardsSection(
                                  features: features,
                                  card1Fade: _card1Fade,
                                  card1Slide: _card1Slide,
                                  card2Fade: _card2Fade,
                                  card2Slide: _card2Slide,
                                  card3Fade: _card3Fade,
                                  card3Slide: _card3Slide,
                                  actionsFade: _actionsFade,
                                  actionsSlide: _actionsSlide,
                                  onAddMoneyPressed: _triggerSuccessBurst,
                                  onClaimGiftCardTapped: () => _showSnackBar(
                                    'Gift Card Claim sheet opened',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Floating App Bar
                  FloatingAppBar(
                    appBarFade: _appBarFade,
                    safeTop: safeTop,
                    onBackPressed: () => _showSnackBar('Back button tapped'),
                    onSettingsPressed: () =>
                        _showSnackBar('Settings button tapped'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

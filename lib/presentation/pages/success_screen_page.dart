import 'package:flutter/material.dart';
import '../../core/bloc/bloc_provider.dart';
import '../cubit/success_screen_cubit.dart';
import '../cubit/success_screen_state.dart';
import '../widgets/action_buttons.dart';
import '../widgets/confetti_overlay.dart';
import '../widgets/dotted_background.dart';
import '../widgets/feature_card.dart';
import '../widgets/wallet_widget.dart';

class SuccessScreenPage extends StatefulWidget {
  const SuccessScreenPage({super.key});

  @override
  State<SuccessScreenPage> createState() => _SuccessScreenPageState();
}

class _SuccessScreenPageState extends State<SuccessScreenPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final GlobalKey<ConfettiOverlayState> _confettiKey = GlobalKey<ConfettiOverlayState>();

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

    // 1. Initialise the animation controller (3.0 seconds total sequence)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // 2. Wallet Scale (Elastic bounce up from 0 to 1 at center-screen)
    _walletScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.35, curve: Curves.elasticOut),
      ),
    );

    // 3. Wallet Position translation (Shrinking spacer from center to top)
    _walletPosition = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeInOutCubic),
      ),
    );

    // 4. "blinkit MONEY" Title Entrance (Fade and slide up)
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.55, 0.75, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0.0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.55, 0.75, curve: Curves.easeOutBack),
      ),
    );

    // 5. Card 1 Animation
    _card1Fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.65, 0.85, curve: Curves.easeOut),
      ),
    );
    _card1Slide = Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.65, 0.85, curve: Curves.easeOutQuad),
      ),
    );

    // 6. Card 2 Animation
    _card2Fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 0.95, curve: Curves.easeOut),
      ),
    );
    _card2Slide = Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 0.95, curve: Curves.easeOutQuad),
      ),
    );

    // 7. Card 3 Animation
    _card3Fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.78, 0.94, curve: Curves.easeOut),
      ),
    );
    _card3Slide = Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.78, 0.94, curve: Curves.easeOutQuad),
      ),
    );

    // 8. Actions (Add money & Claim Gift Card) Entrance
    _actionsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.86, 0.98, curve: Curves.easeOut),
      ),
    );
    _actionsSlide = Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.86, 0.98, curve: Curves.easeOutQuad),
      ),
    );

    // 9. Navigation buttons fade in at the end
    _appBarFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.90, 1.00, curve: Curves.easeIn),
      ),
    );

    // 10. Load details from Cubit and trigger animation start
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
              // Calculate responsive heights
              final double screenHeight = constraints.maxHeight;
              
              // Spacing needed to center the wallet vertically on startup
              // Wallet height is 110, we offset by safe padding
              final double centerSpacerHeight = (screenHeight * 0.45) - 55 - safeTop;
              const double topSpacerHeight = 24.0;

              return Stack(
                children: [
                  // --- main scrollable content ---
                  Positioned.fill(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            // 1. Dynamic spacer moving wallet from center to top
                            AnimatedBuilder(
                              animation: _walletPosition,
                              builder: (context, child) {
                                // Interpolates spacer height between center state and top state
                                final double currentSpacer = topSpacerHeight +
                                    (centerSpacerHeight - topSpacerHeight) * _walletPosition.value;
                                return SizedBox(height: safeTop + currentSpacer);
                              },
                            ),

                            // 2. Animated Wallet
                            ScaleTransition(
                              scale: _walletScale,
                              child: const WalletWidget(),
                            ),
                            const SizedBox(height: 24),

                            // 3. Title section ("blinkit MONEY")
                            FadeTransition(
                              opacity: _titleFade,
                              child: SlideTransition(
                                position: _titleSlide,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'blinkit',
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'MONEY',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: const Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),

                            // 4. Feature Cards & Buttons List (Dynamic data from Cubit)
                            BlocBuilder<SuccessScreenCubit, SuccessScreenState>(
                              builder: (context, state) {
                                if (state is SuccessScreenLoading || state is SuccessScreenInitial) {
                                  // Shimmer style or just clean spacer during load (which is fast)
                                  return const SizedBox(height: 300);
                                }

                                final features = (state as SuccessScreenLoaded).features;

                                return Column(
                                  children: [
                                    // Staggered Feature Card 1
                                    if (features.isNotEmpty)
                                      FadeTransition(
                                        opacity: _card1Fade,
                                        child: SlideTransition(
                                          position: _card1Slide,
                                          child: FeatureCard(item: features[0]),
                                        ),
                                      ),

                                    // Staggered Feature Card 2
                                    if (features.length > 1)
                                      FadeTransition(
                                        opacity: _card2Fade,
                                        child: SlideTransition(
                                          position: _card2Slide,
                                          child: FeatureCard(item: features[1]),
                                        ),
                                      ),

                                    // Staggered Feature Card 3
                                    if (features.length > 2)
                                      FadeTransition(
                                        opacity: _card3Fade,
                                        child: SlideTransition(
                                          position: _card3Slide,
                                          child: FeatureCard(item: features[2]),
                                        ),
                                      ),
                                    
                                    const SizedBox(height: 12),

                                    // Staggered Actions Section (Buttons & Banner)
                                    FadeTransition(
                                      opacity: _actionsFade,
                                      child: SlideTransition(
                                        position: _actionsSlide,
                                        child: Column(
                                          children: [
                                            AddMoneyButton(
                                              onPressed: () {
                                                // Trigger delight confetti burst on tapping Add Money
                                                _triggerSuccessBurst();
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            ClaimGiftCardTile(
                                              onTap: () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Gift Card Claim sheet opened'),
                                                    duration: Duration(seconds: 1),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 12),
                                            const WatermarkFooter(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // --- Custom Semi-Transparent Floating AppBar ---
                  Positioned(
                    top: safeTop + 10,
                    left: 16,
                    right: 16,
                    child: FadeTransition(
                      opacity: _appBarFade,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          _buildRoundActionButton(
                            icon: Icons.chevron_left_rounded,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Back button tapped'),
                                  duration: Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                          // Settings Button
                          _buildRoundActionButton(
                            icon: Icons.settings_outlined,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Settings button tapped'),
                                  duration: Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRoundActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1.0,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24),
        onPressed: onTap,
        splashRadius: 24,
      ),
    );
  }
}

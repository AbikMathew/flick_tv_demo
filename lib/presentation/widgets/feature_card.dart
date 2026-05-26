import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/feature_item.dart';
import 'custom_icon_painter.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.item,
  });

  final FeatureItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withOpacity(0.85), // Semi-transparent glass look
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.cardBorder,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Custom painted high-fidelity vector icon
          CustomIcon(type: item.iconType),
          const SizedBox(width: 16),
          // Title and description text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 0.15,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.25,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

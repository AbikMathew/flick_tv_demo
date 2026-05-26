class FeatureItem {
  const FeatureItem({
    required this.id,
    required this.title,
    required this.description,
    required this.iconType,
  });

  final String id;
  final String title;
  final String description;
  final String iconType; // 'tap', 'failures', 'refunds'
}

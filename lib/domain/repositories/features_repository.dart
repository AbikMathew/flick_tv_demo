import '../entities/feature_item.dart';

abstract class FeaturesRepository {
  Future<List<FeatureItem>> getFeatureItems();
}

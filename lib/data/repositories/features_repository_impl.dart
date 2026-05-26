import '../../domain/entities/feature_item.dart';
import '../../domain/repositories/features_repository.dart';
import '../models/feature_item_model.dart';

class FeaturesRepositoryImpl implements FeaturesRepository {
  @override
  Future<List<FeatureItem>> getFeatureItems() async {
    // Simulate minor network delay (adds realism to the loading state and initial transition)
    await Future<void>.delayed(const Duration(milliseconds: 300));
    
    return [
      const FeatureItemModel(
        id: '1',
        title: 'Single tap payments',
        description: 'Enjoy seamless payments without the wait for OTPs',
        iconType: 'tap',
      ),
      const FeatureItemModel(
        id: '2',
        title: 'Zero failures',
        description: 'Zero payment failures ensure you never miss an order',
        iconType: 'failures',
      ),
      const FeatureItemModel(
        id: '3',
        title: 'Real-time refunds',
        description: 'No need to wait for refunds. Blinkit Money refunds are instant!',
        iconType: 'refunds',
      ),
    ];
  }
}

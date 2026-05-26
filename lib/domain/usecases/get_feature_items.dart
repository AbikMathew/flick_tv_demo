import '../entities/feature_item.dart';
import '../repositories/features_repository.dart';

class GetFeatureItems {
  GetFeatureItems(this._repository);

  final FeaturesRepository _repository;

  Future<List<FeatureItem>> call() async {
    return _repository.getFeatureItems();
  }
}

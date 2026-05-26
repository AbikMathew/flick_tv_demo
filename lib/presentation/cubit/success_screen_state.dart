import '../../domain/entities/feature_item.dart';

abstract class SuccessScreenState {
  const SuccessScreenState();
}

class SuccessScreenInitial extends SuccessScreenState {
  const SuccessScreenInitial();
}

class SuccessScreenLoading extends SuccessScreenState {
  const SuccessScreenLoading();
}

class SuccessScreenLoaded extends SuccessScreenState {
  const SuccessScreenLoaded({required this.features});

  final List<FeatureItem> features;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuccessScreenLoaded &&
          runtimeType == other.runtimeType &&
          features == other.features;

  @override
  int get hashCode => features.hashCode;
}

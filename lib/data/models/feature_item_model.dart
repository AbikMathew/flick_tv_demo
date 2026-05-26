import '../../domain/entities/feature_item.dart';

class FeatureItemModel extends FeatureItem {
  const FeatureItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.iconType,
  });

  factory FeatureItemModel.fromJson(Map<String, dynamic> json) {
    return FeatureItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconType: json['iconType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconType': iconType,
    };
  }
}

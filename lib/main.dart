import 'package:flutter/material.dart';
import 'core/bloc/bloc_provider.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/features_repository_impl.dart';
import 'domain/usecases/get_feature_items.dart';
import 'presentation/cubit/success_screen_cubit.dart';
import 'presentation/pages/success_screen_page.dart';

void main() {
  // 1. Instantiate Clean Architecture Dependencies
  final featuresRepository = FeaturesRepositoryImpl();
  final getFeatureItems = GetFeatureItems(featuresRepository);

  runApp(
    MyApp(
      getFeatureItems: getFeatureItems,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.getFeatureItems,
  });

  final GetFeatureItems getFeatureItems;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blinkit Money Success Screen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocProvider<SuccessScreenCubit>(
        create: (context) => SuccessScreenCubit(getFeatureItems),
        child: const SuccessScreenPage(),
      ),
    );
  }
}

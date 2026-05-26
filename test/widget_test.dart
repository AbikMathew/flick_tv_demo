import 'package:flutter_test/flutter_test.dart';
import 'package:abik/main.dart';
import 'package:abik/domain/usecases/get_feature_items.dart';
import 'package:abik/data/repositories/features_repository_impl.dart';

void main() {
  testWidgets('Blinkit Money Success Screen Smoke Test', (WidgetTester tester) async {
    // Instantiate real/mock dependencies for test
    final featuresRepository = FeaturesRepositoryImpl();
    final getFeatureItems = GetFeatureItems(featuresRepository);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MyApp(
        getFeatureItems: getFeatureItems,
      ),
    );

    // Let the loading timer (300ms) and opening animations complete
    await tester.pumpAndSettle();

    // Verify page opens and shows title elements
    expect(find.text('blinkit'), findsOneWidget);
    expect(find.text('MONEY'), findsOneWidget);
  });
}

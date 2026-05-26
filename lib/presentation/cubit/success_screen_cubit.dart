import '../../core/bloc/cubit.dart';
import '../../domain/usecases/get_feature_items.dart';
import 'success_screen_state.dart';

class SuccessScreenCubit extends Cubit<SuccessScreenState> {
  SuccessScreenCubit(this._getFeatureItems) : super(const SuccessScreenInitial());

  final GetFeatureItems _getFeatureItems;

  Future<void> loadFeatures() async {
    emit(const SuccessScreenLoading());
    try {
      final features = await _getFeatureItems();
      emit(SuccessScreenLoaded(features: features));
    } catch (e) {
      // In a real app we'd emit a failure state; here we fall back to empty list on error
      emit(const SuccessScreenLoaded(features: []));
    }
  }
}

import 'package:dish_dash/features/saved_screen/presentation/manager/saved_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/food_model.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedInitial());

  static SavedCubit get(context) => BlocProvider.of(context);

  List<FoodData> foodDataList = [];
  void saveAndAddData(FoodData foodData) {
    if (!foodDataList.contains(foodData)) {
      foodDataList.add(foodData);
    } else {
      foodDataList.remove(foodData);
    }
    emit(SavedSuccess(
        List.from(foodDataList))); // Emit a new state with a copy of the list
  }

  bool changeSave(FoodData foodData) {
    bool isSave = foodDataList.contains(foodData);
    emit(SavedSuccess(
        List.from(foodDataList))); // Emit a new state with a copy of the list
    return isSave;
  }
}

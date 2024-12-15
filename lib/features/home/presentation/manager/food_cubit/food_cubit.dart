import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/home_repo.dart';
import 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  final HomeRepo homeRepo;
  static FoodCubit get(context) => BlocProvider.of(context);

  FoodCubit(this.homeRepo) : super(FoodInitialState());
  void getAllFoods(String area) async {
    emit(FoodLoadingState());

    var foods = await homeRepo.getAllFood(area);

    foods.fold((error) {
      emit(FoodFailureState(apiErrorModel: error));
    }, (food) {
      emit(FoodSuccessState(foodModel: food));
    });
  }
}

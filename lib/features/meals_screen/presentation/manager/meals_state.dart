import 'package:dish_dash/core/network/api_error_model.dart';
import 'package:dish_dash/features/meals_screen/data/models/meal_model.dart';

abstract class MealsState {}

class MealsInitialState extends MealsState {}

class MealsLoadingState extends MealsState {}

class MealsSuccessState extends MealsState {
  final MealModel mealModel;

  MealsSuccessState({required this.mealModel});
}

class MealsFailureState extends MealsState {
  final ApiErrorModel apiErrorModel;

  MealsFailureState({required this.apiErrorModel});
}

import 'package:dartz/dartz.dart';
import 'package:dish_dash/core/network/api_error_handler.dart';
import 'package:dish_dash/core/network/api_error_model.dart';
import 'package:dish_dash/core/network/api_services.dart';
import 'package:dish_dash/features/meals_screen/data/models/meal_model.dart';

class MealRepo {
  final ApiServices apiServices;

  MealRepo(this.apiServices);

  Future<Either<ApiErrorModel, MealModel>> getAllMeals(String meal) async {
    try {
      var response = await apiServices.getAllMeals(meal);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_error_model.dart';
import '../../../../core/network/api_services.dart';
import '../model/meals_model_response.dart';

class DetailsRepo{

  final ApiServices _apiServices ;

  DetailsRepo(this._apiServices);

  Future<Either<ApiErrorModel , MealsModelResponse>> getMealDetails(String id) async{
    try {
      var mealsData = await _apiServices.getMealsDetails(id);
        return Right(mealsData);
    }  catch (error) {
      return Left(ApiErrorHandler.handle(error.toString()));
    }
  }
}
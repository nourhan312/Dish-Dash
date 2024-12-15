import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

import '../../features/details/data/model/meals_model_response.dart';
import '../../features/home/data/models/area_model.dart';
import '../../features/home/data/models/category_model.dart';
import '../../features/home/data/models/food_model.dart';
import '../../features/meals_screen/data/models/meal_model.dart';
import '../../features/search/data/model/search_model_response.dart';
import 'api_constants.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @GET(ApiConstants.categories)
  Future<CategoryModel> getAllCategories();

  @GET(ApiConstants.areas)
  Future<AreaModel> getAllAreas();

  @GET(ApiConstants.filter)
  Future<FoodModel> getAllFood(
    @Query("a") String area,
  );

  @GET(ApiConstants.filter)
  Future<MealModel> getAllMeals(
    @Query("c") String meal,
  );

  @GET(ApiConstants.searchUsingName)
  Future<SearchModelResponse> searchUsingName(
    @Query("s") String name,
  );

  @GET(ApiConstants.detailsUsingId)
  Future<MealsModelResponse> getMealsDetails(
    @Query("i") String id,
  );

  @GET(ApiConstants.searchByFirstChar)
  Future<SearchModelResponse> getMealsByFirstChar(
    @Query("f") String firstChar,
  );
}

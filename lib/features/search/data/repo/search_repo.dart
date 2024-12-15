import 'package:dartz/dartz.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_error_model.dart';
import '../../../../core/network/api_services.dart';
import '../model/search_model_response.dart';

class SearchRepo {
  final ApiServices _apiServices;

  SearchRepo(this._apiServices);

  Future<Either<ApiErrorModel, SearchModelResponse>> searchUsingName(
      {required String name}) async {
    try {
      var searchData = await _apiServices.searchUsingName(name);
      if (searchData.mealsData == null) {
        return Left(ApiErrorHandler.handle("No Data available for this name"));
      } else {
        return Right(searchData);
      }
    } catch (error) {
      return Left(ApiErrorHandler.handle(error.toString()));
    }
  }
}

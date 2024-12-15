
import '../../../../core/network/api_error_model.dart';
import '../../data/model/meals_model_response.dart';

class DetailsState {}

 class DetailsInitial extends DetailsState {}
 class DetailsLoading extends DetailsState {}
 class DetailsSuccess extends DetailsState {
  final MealsModelResponse mealsModelResponse;

  DetailsSuccess(this.mealsModelResponse);
 }
 class DetailsFailed extends DetailsState {
  final ApiErrorModel apiErrorModel;

  DetailsFailed(this.apiErrorModel);
 }

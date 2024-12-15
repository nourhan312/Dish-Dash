import '../../../../../core/network/api_error_model.dart';
import '../../../data/models/category_model.dart';

class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  final CategoryModel categoryModel;

  CategorySuccessState({required this.categoryModel});
}

class CategoryFailureState extends CategoryState {
  final ApiErrorModel apiErrorModel;

  CategoryFailureState({required this.apiErrorModel});
}

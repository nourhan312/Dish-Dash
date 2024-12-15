import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/home_repo.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeRepo homeRepo;
  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoryCubit(this.homeRepo) : super(CategoryInitialState());
  void getAllCategories() async {
    emit(CategoryLoadingState());

    var categories = await homeRepo.getAllCategories();

    categories.fold((error) {
      emit(CategoryFailureState(apiErrorModel: error));
    }, (categories) {
      emit(CategorySuccessState(categoryModel: categories));
    });
  }
}

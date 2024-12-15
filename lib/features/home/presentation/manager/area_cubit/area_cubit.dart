import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/home_repo.dart';
import 'area_state.dart';

class AreaCubit extends Cubit<AreaState> {
  final HomeRepo homeRepo;
  static AreaCubit get(context) => BlocProvider.of(context);

  AreaCubit(this.homeRepo) : super(AreaInitialState());
  void getAllAreas() async {
    emit(AreaLoadingState());

    var areas = await homeRepo.getAllArea();

    areas.fold((error) {
      emit(AreaFailureState(apiErrorModel: error));
    }, (area) {
      emit(AreaSuccessState(areaModel: area));
    });
  }
}

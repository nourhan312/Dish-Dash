import '../../../../../core/network/api_error_model.dart';
import '../../../data/models/area_model.dart';

abstract class AreaState {}

class AreaInitialState extends AreaState {}

class AreaLoadingState extends AreaState {}

class AreaSuccessState extends AreaState {
  final AreaModel areaModel;

  AreaSuccessState({required this.areaModel});
}

class AreaFailureState extends AreaState {
  final ApiErrorModel apiErrorModel;

  AreaFailureState({required this.apiErrorModel});
}

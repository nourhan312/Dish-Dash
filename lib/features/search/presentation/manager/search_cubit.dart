import 'dart:async';
import '../../data/model/search_model_response.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);
  final TextEditingController nameController = TextEditingController();
  final SearchRepo searchRepo;
  Timer? _debounce; // Timer for debouncing

  void searchUsingName(name) async {
    // Cancel the previous timer if it exists
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new timer (e.g., 500 milliseconds)
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (name.isEmpty) {
        emit(SearchInitial());
        return;
      }

      if (name.isEmpty) {
        emit(SearchInitial());
        return;
      }
      emit(SearchLoading());
      var searchData = await searchRepo.searchUsingName(name: name);
      searchData.fold(
        (error) {
          emit(SearchFailed(error.toString()));
        },
        (searchModelResponse) {
          emit(SearchSuccess(searchModelResponse));
        },
      );
    });
  }

// Dispose controllers
  void disposeControllers() {
    nameController.dispose();
    _debounce?.cancel();
  }

  @override
  Future<void> close() {
    disposeControllers();
    return super.close();
  }
}

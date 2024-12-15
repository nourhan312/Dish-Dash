import 'package:dish_dash/features/search/presentation/screen/widgets/search_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/widgets/custom_error_message.dart';
import '../../manager/search_cubit.dart';
import '../../manager/search_state.dart';

class SearchItemsListViewBlocBuilder extends StatelessWidget {
  const SearchItemsListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is SearchLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColor.mainBrown,
          ),
        );
      } else if (state is SearchSuccess) {
        return getSearchData(state.searchModelResponse);
      } else if (state is SearchFailed) {
        return const CustomMessage(error: "No meals for this name");
      } else {
        return const CustomMessage(
          error: "Start typing to find your meals...",
          backgroundColor: AppColor.mainBrown,
        );
      }
    });
  }

  Widget getSearchData(searchModelResponse) {
    return SearchItemsListView(searchModelResponse: searchModelResponse);
  }
}

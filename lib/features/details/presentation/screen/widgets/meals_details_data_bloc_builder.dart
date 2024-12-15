import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_error_message.dart';
import '../../../../../core/widgets/shimmer_widget.dart';
import '../../manager/details_cubit.dart';
import '../../manager/details_state.dart';
import 'details_loading_shimmer.dart';
import 'meals_details_list_view.dart';

class MealsDetailsDataBlocBuilder extends StatelessWidget {
  const MealsDetailsDataBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return DetailsLoadingShimmer();
        } else if (state is DetailsSuccess) {
          return getMealsDetailsData(state.mealsModelResponse);
        } else if (state is DetailsFailed) {
          return Center(
            child: CustomMessage(error: state.apiErrorModel.message.toString()),
          );
        } else {
          return ShimmerWidget(
            widget: Column(
              children: List.generate(1, (index) => ShimmerPlaceholder()),
            ),
          );
        }
      },
    );
  }

  Widget getMealsDetailsData(mealsModelResponse) {
    return MealsDetailsListView(mealsModelResponse: mealsModelResponse);
  }
}

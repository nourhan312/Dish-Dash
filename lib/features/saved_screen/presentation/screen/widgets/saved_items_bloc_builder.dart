import 'package:dish_dash/features/saved_screen/presentation/screen/widgets/saved_items_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/widgets/custom_error_message.dart';
import '../../manager/saved_cubit.dart';
import '../../manager/saved_state.dart';

class SavedItemsBlocBuilder extends StatelessWidget {
  const SavedItemsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedCubit, SavedState>(builder: (context, state) {
      if (state is SavedSuccess) {
        return SavedItemsGridView(foodDataList: state.foodData);
      } else {
        return CustomMessage(
          error: "No data saved yet",
          backgroundColor: AppColor.mainBrown,
        );
      }
    });
  }
}

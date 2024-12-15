import 'package:dish_dash/features/search/presentation/screen/widgets/search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/search_model_response.dart';

class SearchItemsListView extends StatelessWidget {
  const SearchItemsListView({super.key, required this.searchModelResponse});
  final SearchModelResponse searchModelResponse;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchModelResponse.mealsData!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: 15.h,
          ),
          child: SearchItem(
            mealsData: searchModelResponse.mealsData![index],
          ),
        );
      },
    );
  }
}

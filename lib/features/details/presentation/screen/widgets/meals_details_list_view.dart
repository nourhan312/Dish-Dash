import 'package:dish_dash/features/details/presentation/screen/widgets/show_youtube_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/meals_model_response.dart';
import 'meal_details.dart';

class MealsDetailsListView extends StatelessWidget {
  const MealsDetailsListView({super.key, required this.mealsModelResponse});

  final MealsModelResponse mealsModelResponse;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: mealsModelResponse.mealsDetails!.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowYoutubeVideo(
                mealsDetails: mealsModelResponse.mealsDetails![index],
              ),
              SizedBox(
                height: 24.h,
              ),
              MealDetails(
                mealDetails: mealsModelResponse.mealsDetails![index],
              ),
            ],
          );
        });
  }
}

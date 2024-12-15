import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/widgets/custom_image_network.dart';
import '../../../data/model/search_model_response.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.mealsData});

  final MealsData? mealsData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.detailsScreen, arguments: mealsData!.id);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: AppColor.antiFlashWhite, blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
                child: CustomImageNetwork(imagePath: mealsData!.mealImage)),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Text(
                mealsData!.mealName,
                style: AppTextStyle.font14DarkGreenMedium,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

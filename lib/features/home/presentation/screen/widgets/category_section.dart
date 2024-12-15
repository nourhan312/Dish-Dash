import 'package:dish_dash/features/home/presentation/screen/widgets/CroupPhoto_Box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dish_dash/core/theme/app_text_style.dart';
import 'package:dish_dash/features/home/presentation/screen/widgets/categories_tab_bar.dart';
import 'package:dish_dash/features/home/presentation/screen/widgets/category_item.dart';

import '../../../../../core/widgets/Ads_Box.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s in your fridge?',
          style: AppTextStyle.font18DarkGreenSemiBold,
        ),
        SizedBox(
          height: 15.h,
        ),
        const CategoryItem(),
        GroupPhotoBox(
          BoxTitle: 'Our Teams',
        ),
        const CategoryTabBar(),
      ],
    );
  }
}

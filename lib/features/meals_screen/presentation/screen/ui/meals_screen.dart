import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dish_dash/core/theme/app_color.dart';
import 'package:dish_dash/features/meals_screen/presentation/screen/widgets/meals_body.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Meals',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.mainBrown,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: MealsBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/Ads_Box.dart';
import '../widgets/category_section.dart';
import '../widgets/header_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),
              AdsBox(
                revere: false,
              ),
              SizedBox(
                height: 30.h,
              ),
              const CategorySection(),
            ],
          ),
        ),
      ),
    );
  }
}

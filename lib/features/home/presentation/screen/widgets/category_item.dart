import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dish_dash/core/widgets/shimmer_widget.dart';
import 'package:dish_dash/core/routes/routes.dart';
import 'package:dish_dash/core/theme/app_color.dart';
import 'package:dish_dash/features/home/presentation/manager/category_cubit/category_cubit.dart';
import 'package:dish_dash/features/home/presentation/manager/category_cubit/category_state.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  CategoryItemState createState() => CategoryItemState();
}

class CategoryItemState extends State<CategoryItem> {
  String selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              14,
              (index) => ShimmerWidget(
                widget: Container(
                  width: 100.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15.0.r),
                  ),
                ),
              ),
            ),
          );
        } else if (state is CategorySuccessState) {
          final categories = state.categoryModel.categroyData;

          return Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: categories.map((category) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.mealsScreen,
                      arguments: category.name);
                  setState(() {
                    selectedItem =
                        category.name == selectedItem ? '' : category.name;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: category.name == selectedItem
                        ? Colors.brown.shade900
                        : AppColor.lightSlateGray,
                    borderRadius: BorderRadius.circular(15.0.r),
                  ),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      color: category.name == selectedItem
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        } else if (state is CategoryFailureState) {
          return const Center(
            child: Text('Failed to load categories.'),
          );
        }
        return Container();
      },
    );
  }
}

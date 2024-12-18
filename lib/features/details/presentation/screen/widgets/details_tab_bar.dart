import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../manager/details_cubit.dart';
import '../../manager/details_state.dart';

class DetailsTabBar extends StatelessWidget {
  const DetailsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
          BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoading) {
                return CircularProgressIndicator();
              } else if (state is DetailsSuccess) {
                return GestureDetector(
                  onTap: () {
                    Share.share(
                        "Meal Name : ${state.mealsModelResponse.mealsDetails![0]!.name.toString()}\nMeal Link : ${state.mealsModelResponse.mealsDetails![0]!.youtubeLink.toString()}");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                );
              } else if (state is DetailsFailed) {
                return Icon(Icons.share);
              } else {
                return Icon(Icons.share);
              }
            },
          ),
        ],
      ),
    );
  }
}

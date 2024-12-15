import 'package:flutter/material.dart';

import 'details_tab_bar.dart';
import 'meals_details_data_bloc_builder.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsTabBar(),
            MealsDetailsDataBlocBuilder(),
          ],
        ),
      ),
    );
  }
}

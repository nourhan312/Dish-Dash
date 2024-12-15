import 'package:dish_dash/features/saved_screen/presentation/screen/widgets/saved_items_bloc_builder.dart';
import 'package:flutter/material.dart';

class SavedBody extends StatelessWidget {
  const SavedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          children: [
            Expanded(child: SavedItemsBlocBuilder()),
          ],
        ),
      ),
    );
  }
}

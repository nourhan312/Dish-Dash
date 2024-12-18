import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../features/category/category.dart';
import '../../features/home/presentation/screen/ui/home_screen.dart';
import '../../features/saved_screen/presentation/screen/ui/saved_screen.dart';
import '../../features/search/presentation/screen/ui/search_screen.dart';
import '../theme/app_color.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const SavedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.bookmark,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: AppColor.mainBrown,
        buttonBackgroundColor: AppColor.mainBrown,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: screens[page],
    );
  }
}

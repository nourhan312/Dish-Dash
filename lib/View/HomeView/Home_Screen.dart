import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dish_dash/Controler/Area_Data.dart';
import 'package:dish_dash/Controler/Ingredient_Data.dart';
import 'package:dish_dash/View/HomeView/HomeBox/Ads_Box.dart';
import 'package:dish_dash/View/HomeView/HomeBox/Categorie_Box.dart';
import 'package:dish_dash/View/HomeView/HomeBox/CroupPhoto_Box.dart';
import 'package:dish_dash/View/HomeView/HomeBox/Food_Box.dart';
import 'package:dish_dash/View/HomeView/HomeBox/Header_Box.dart';
import 'package:dish_dash/View/HomeView/HomeBox/Item_Box.dart';
import 'package:dish_dash/View/HomeView/HomeBox/MostWatched_Box.dart';
import 'package:dish_dash/View/Categorie_Screen.dart';
import 'package:dish_dash/View/SeeAllMeal_Screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //MealData.printMealByID('52770');
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          const HeaderBox(),
          // const SearchBox(),
          // const SizedBox(height: 10),
          AdsBox(revere: false),
          ItemsBox(
            bkg: Colors.brown.shade900,
            futureList: IngredientData.GetIngredientTitle(),
            filterType: 'Ingredient',
          ),
          CategorieBox(
            BoxTitle: 'Categories',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const CategorieScreen()));
            },
          ),
          FoodBox(
              FirstChar: 'c',
              BoxTitle: 'Popular Meals',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SeeAllMeals(
                              ScreenTitle: 'Popular Meals',
                              firstChar: 'c',
                            )));
              }),
          FoodBox(
              FirstChar: 'm',
              BoxTitle: 'Recent Search',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SeeAllMeals(
                              ScreenTitle: 'Recent Search',
                              firstChar: 'm',
                            )));
              }),
          GroupPhotoBox(
            BoxTitle: 'Our Teams',
            onPressed: () {
              if (kDebugMode) {
                print('Go To Photo Screen');
              }
            },
          ),
          ItemsBox(
            bkg: Colors.black,
            futureList: AreaData.getArea(),
            filterType: 'Area',
          ),
          FoodBox(
              FirstChar: 'l',
              BoxTitle: 'Top Reviews',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SeeAllMeals(
                              ScreenTitle: 'Top Reviews',
                              firstChar: 'l',
                            )));
              }),
          FoodBox(
              FirstChar: 'b',
              BoxTitle: 'Top Search',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SeeAllMeals(
                      ScreenTitle: 'Top Search',
                      firstChar: 'b',
                    ),
                  ),
                );
              }),

          const MostWatchedBox(FirstChar: 'k'),
        ],
      ),
    );
  }
}

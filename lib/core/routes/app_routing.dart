import 'package:dish_dash/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/details/presentation/manager/details_cubit.dart';
import '../../features/details/presentation/screen/ui/details_screen.dart';
import '../../features/home/presentation/manager/area_cubit/area_cubit.dart';
import '../../features/home/presentation/manager/category_cubit/category_cubit.dart';
import '../../features/home/presentation/manager/food_cubit/food_cubit.dart';
import '../../features/home/presentation/manager/logout_cubit/logout_cubit.dart';
import '../../features/home/presentation/screen/ui/home_screen.dart';
import '../../features/login/presentation/manager/login_cubit.dart';
import '../../features/login/presentation/screen/ui/login_screen.dart';
import '../../features/meals_screen/presentation/manager/meals_cubit.dart';
import '../../features/meals_screen/presentation/screen/ui/meals_screen.dart';
import '../../features/on_boarding/presentation/screen/ui/on_boarding_screen.dart';
import '../../features/register/presentation/manager/register_cubit.dart';
import '../../features/register/presentation/screen/ui/register_screen.dart';
import '../../features/saved_screen/presentation/manager/saved_cubit.dart';
import '../../features/search/presentation/manager/search_cubit.dart';
import '../../features/search/presentation/screen/ui/search_screen.dart';
import '../../features/splash/presentation/screen/ui/splash_screen.dart';
import '../di/dependency_injection.dart';
import '../widgets/bottom_bar.dart';

class AppRouting {
  Route? generateRoute(RouteSettings routesSettings) {
    final arguments = routesSettings.arguments;
    switch (routesSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.mealsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            key: ValueKey(arguments),
            create: (context) =>
                getIt<MealCubit>()..getAllMeals(arguments as String),
            child: const MealsScreen(),
          ),
        );
      case Routes.onBoardingScreen:
        return PageRouteBuilder(
          transitionDuration: const Duration(seconds: 3),
          // Set the duration of the animation
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnBoardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Apply a curved animation
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Start from right side
                end: Offset.zero, // Slide to the center
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );
      case Routes.bottomBar:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<LogoutCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<CategoryCubit>()..getAllCategories(),
              ),
              BlocProvider(
                create: (_) => getIt<AreaCubit>()..getAllAreas(),
              ),
              BlocProvider(
                create: (_) => getIt<FoodCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<SearchCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<SavedCubit>(),
              ),
            ],
            child: const BottomNavBar(),
          ),
        );

      case Routes.detailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            key: ValueKey(arguments),
            create: (context) =>
                getIt<DetailsCubit>()..getAllMealDetails(arguments as String),
            child: const DetailsScreen(),
          ),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<SearchCubit>(),
            child: SearchScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<CategoryCubit>()..getAllCategories(),
              ),
              BlocProvider(
                create: (_) => getIt<AreaCubit>()..getAllAreas(),
              ),
              BlocProvider(
                create: (_) => getIt<FoodCubit>(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routesSettings.name}'),
            ),
          ),
        );
    }
  }
}

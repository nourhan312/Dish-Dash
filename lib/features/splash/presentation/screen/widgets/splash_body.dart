// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/helper/app_images.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared_pref/app_prefs.dart';
import '../../../../../core/theme/app_color.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  final AppPreferences appPreferences = getIt<AppPreferences>();
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  _startDelay() {
    Timer(
      const Duration(seconds: 3),
      _goNext,
    );
  }

  _goNext() {
    appPreferences.isUserLoggedIn().then(
      (isLoggedIn) {
        if (isLoggedIn) {
          if (context.mounted) {
            Navigator.of(context).pushReplacementNamed(Routes.bottomBar);
          }
        } else {
          appPreferences.isOnBoardingScreenViewed().then(
            (isViewObBoarding) {
              if (isViewObBoarding) {
                if (context.mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.loginScreen);
                }
              } else {
                if (context.mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.onBoardingScreen);
                }
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.mainBrown,
      width: double.infinity,
      child: Image.asset(
        AppImages.splashLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}

// import 'package:dish_dash/View/on_boarding/onboarding_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:provider/provider.dart';
// import 'Controler/id_provider.dart';
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => IdProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: ThemeData(fontFamily: 'lato'),
//       home: const OnboardingScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'core/di/dependency_injection.dart';
import 'core/routes/app_routing.dart';
import 'dish_dash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setup();
  runApp(
    DishDash(
      appRouting: AppRouting(),
    ),
  );
}

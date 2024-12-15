import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// bool result = await InternetConnection().hasInternetAccess;

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Dialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SpinKitWaveSpinner(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      );
    },
  );
}

showMessage({
  context,
  required String title,
  required String data,
  required Color achieveColor,
}) {
  AchievementView(
    title: title,
    subTitle: data,
    color: achieveColor,
    duration: const Duration(seconds: 2),
    elevation: 2,
    icon: Icon(
      Icons.tag_faces_sharp,
      color: Theme.of(context).scaffoldBackgroundColor,
    ),
    textStyleTitle: TextStyle(
        fontFamily: 'Dosis', color: Theme.of(context).scaffoldBackgroundColor),
    textStyleSubTitle: TextStyle(
        fontFamily: 'Dosis', color: Theme.of(context).scaffoldBackgroundColor),
    borderRadius: BorderRadius.circular(20),
  ).show(context);
}

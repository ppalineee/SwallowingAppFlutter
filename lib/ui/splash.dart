import 'dart:async';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/assets.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/constants/strings.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.deepblue,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // AppIconWidget(image: Assets.appLogo),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Text(
                    Strings.appName,
                    style: TextStyle(
                      fontFamily: FontFamily.roboto,
                      fontWeight: FontWeight.w300,
                      fontSize: 26,
                      color: AppColors.white,
                    ),
                  )
                ],
              )),
        ));
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}

import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/login.dart';
import 'ui/splash.dart';
import 'ui/videoplaylist.dart';
import 'ui/article_list.dart';
import 'ui/assignment_list.dart';
import 'ui/assignment_board.dart';
import 'ui/more.dart';
import 'ui/test.dart';
import 'ui/profile.dart';
import 'ui/contact_us.dart';
import 'ui/notification.dart';
import 'ui/setting.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String video_playlist = '/video_playlist';
  static const String article_list = '/article_list';
  static const String assignment_list = '/assignment_list';
  static const String assignment_board = '/assignment_board';
  static const String more = '/more';
  static const String test = '/test';
  static const String profile = '/profile';
  static const String contact_us = '/contact_us';
  static const String notification = '/notification';
  static const String setting = '/setting';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    video_playlist: (BuildContext context) => VideoPlaylistScreen(),
    article_list: (BuildContext context) => ArticleListScreen(),
    assignment_list: (BuildContext context) => AssignmentListScreen(),
    assignment_board: (BuildContext context) => AssignmentBoardScreen(),
    more: (BuildContext context) => MoreScreen(),
    test: (BuildContext context) => TestScreen(),
    profile: (BuildContext context) => ProfileScreen(),
    contact_us: (BuildContext context) => ContactUsScreen(),
    notification: (BuildContext context) => NotificationScreen(),
    setting: (BuildContext context) => SettingScreen(),
  };
}




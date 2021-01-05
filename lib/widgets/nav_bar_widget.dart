import 'package:flutter/cupertino.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/routes.dart';

class Navbar extends StatefulWidget {
  static var selectedIndex = 0;
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return _navBar();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _navBar() {
    return FFNavigationBar(
      theme: _navBarTheme(),
      selectedIndex: Navbar.selectedIndex,
      onSelectTab: (index) {
        setState(() {
          Navbar.selectedIndex = index;
        });
        if (Navbar.selectedIndex == 0) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        } else if (Navbar.selectedIndex == 1) {
          Navigator.of(context).pushReplacementNamed(Routes.video_playlist);
        } else if (Navbar.selectedIndex == 2) {
          Navigator.of(context).pushReplacementNamed(Routes.assignment_list);
        } else if (Navbar.selectedIndex == 3) {
          Navigator.of(context).pushReplacementNamed(Routes.article_list);
        } else if (Navbar.selectedIndex == 4) {
          Navigator.of(context).pushReplacementNamed(Routes.more);
        }
      },
      items: patientNavBarItems,
    );
  }
}

FFNavigationBarTheme _navBarTheme() {
  return FFNavigationBarTheme(
    barBackgroundColor: AppColors.white,
    selectedItemBorderColor: Colors.transparent,
    selectedItemBackgroundColor: AppColors.deepblue,
    selectedItemIconColor: AppColors.white,
    selectedItemLabelColor: AppColors.deepblue,
    selectedItemTextStyle: TextStyle(
      fontFamily: FontFamily.kanit,
      fontSize: 14,
    ),
    unselectedItemTextStyle: TextStyle(
      fontFamily: 'FontFamily.kanit',
      fontSize: 14,
    ),
    showSelectedItemShadow: true,
    barHeight: 65,
  );
}

FFNavigationBarItem homeNav() {
  return FFNavigationBarItem(
    iconData: Icons.home,
    label: 'หน้าหลัก',
  );
}

FFNavigationBarItem videoNav() {
  return FFNavigationBarItem(
    iconData: Icons.video_library,
    label: 'วิดีโอ',
  );
}

FFNavigationBarItem assignmentNav() {
  return FFNavigationBarItem(
    iconData: Icons.assignment_turned_in,
    label: 'แบบฝึกหัด',
  );
}

FFNavigationBarItem articleNav() {
  return FFNavigationBarItem(
    iconData: Icons.menu_book,
    label: 'บทความ',
  );
}

FFNavigationBarItem moreNav() {
  return FFNavigationBarItem(
    iconData: Icons.more_horiz,
    label: 'เพิ่มเติม',
  );
}

List<FFNavigationBarItem> patientNavBarItems = [
  homeNav(),
  videoNav(),
  assignmentNav(),
  articleNav(),
  moreNav()
];

List<FFNavigationBarItem> guestNavBarItems = [
  homeNav(),
  videoNav(),
  articleNav(),
  moreNav()
];

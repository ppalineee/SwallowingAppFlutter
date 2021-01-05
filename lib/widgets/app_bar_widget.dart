import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/routes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool visibilityBackIcon;

  const MyAppBar(
    this.title,
    this.visibilityBackIcon, {
    Key key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(88.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
      width: MediaQuery.of(context).size.width,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.deepblue,
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(children: <Widget>[
              (visibilityBackIcon)
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      width: 50.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 25.0,
                          color: AppColors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ))
                  : SizedBox(
                      width: 25,
                    ),
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: FontFamily.kanit,
                      fontSize: 24,
                      color: AppColors.white),
                ),
              ),
            ]),
            (title == 'การแจ้งเตือน')
            ? SizedBox.shrink()
            : Container(
              alignment: Alignment.center,
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.notification);
                  }),
            )
          ]),
      )
    );
  }
}

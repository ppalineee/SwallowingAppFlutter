import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/models/notification.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/stores/notification_store.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool visibilityBackIcon;

  const MyAppBar({Key key, this.title, this.visibilityBackIcon}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(88.0);
}

class _MyAppBarState extends State<MyAppBar> {
  NotificationStore _notificationStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _notificationStore = Provider.of<NotificationStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.135,
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
            Row(
              children: <Widget>[
              (widget.visibilityBackIcon)
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(left: 10),
                      width: 45,
                      height: 45,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 25.0,
                          color: AppColors.white,
                        ),
                        highlightColor: AppColors.lightgray,
                        onPressed: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp
                          ]);
                          Navigator.of(context).pop();
                        }
                      ))
                  : SizedBox(
                      width: 30,
                      height: 45,
                    ),
              Container(
                width: MediaQuery.of(context).size.width-130,
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: FontFamily.kanit,
                      fontSize: 24,
                      color: AppColors.white),
                ),
              ),
            ]),
            (widget.title == 'หน้าหลัก')
            ? _showNotification()
            : SizedBox.shrink()
          ]),
      )
    );
  }

  Widget _showNotification() {
    return FutureBuilder<NotificationList>(
      future: _notificationStore.getNotification(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final int warningCount = snapshot.data.warningCount;
          if (warningCount > 0) {
            return _buildNotificationIcon(warningCount);
          } else {
            return _buildNotificationIcon(0);
          }
        } else {
          print(snapshot.hasData);
          return _buildNotificationIcon(0);
        }
      },
    );
  }

  Widget _buildNotificationIcon(int warningCount) {
    return Container(
        alignment: Alignment.center,
        width: 45,
        height: 45,
        child: Stack(
          children: [
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                  color: AppColors.white,
                ),
                highlightColor: AppColors.lightgray,
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.notification);
                  _notificationStore.readNotification().then((value) => setState(() {}));
                }),
            (warningCount > 0)
            ? Container(
              width: 45,
              height: 45,
              alignment: Alignment.topRight,
              child: Container(
                width: 27,
                height: 23,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc32c37),
                  border: Border.all(color: AppColors.deepblue, width: 2)
                ),
                child: Center(
                  child: Text(
                    (warningCount < 100) ? warningCount.toString() : '99+',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            )
            : SizedBox.shrink()
          ],
        )
    );
  }
}

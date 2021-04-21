import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/stores/notification_store.dart';
import 'package:swallowing_app/utils/date_format.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/models/notification.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  NotificationStore _notificationStore;
  NotificationList _notificationList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'การแจ้งเตือน', visibilityBackIcon: true),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    _notificationStore = Provider.of<NotificationStore>(context, listen: false);
    _notificationList = _notificationStore.notificationList;
    return Stack(
        children: <Widget>[
          Container(
            color: AppColors.lightgray,
            width: MediaQuery.of(context).size.width,
          ),
          (_notificationList.notifications.length > 0)
          ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _notificationList.notifications.length,
            itemBuilder: (context, index) {
              return _buildNotification(context, _notificationList.notifications[index]);
            },
          )
          : _handleNoNotificationsFound()
        ]
    );
  }

  Widget _buildNotification(BuildContext context, NotificationMessage notification) {
    return Align(
      child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 120
          ),
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: EdgeInsets.symmetric(vertical: 1.5),
              width: MediaQuery.of(context).size.width-50,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width-95,
                          child: Text(
                            notification.title,
                            style: TextStyle(color: AppColors.deepblue, fontSize: 17),
                          ),
                        ),
                        Text(
                          DateFormats.changeThaiShortFormat(notification.timestamp),
                          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w300, fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width-95,
                          child: Text(
                            notification.message,
                            style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w300, fontSize: 15),
                          ),
                        ),
                      ]
                  )
                ],
              )
          )
      ),
    );
  }

  Widget _handleNoNotificationsFound() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
              child: Icon(
                Icons.inbox,
                size: 50,
                color: Colors.black45,
              )
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'ไม่มีข้อความแจ้งเตือนใหม่...',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 20),
            ),
          )
        ]
    );
  }
}